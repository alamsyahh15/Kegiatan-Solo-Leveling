package com.udacoding.transactionpurchaseapp.view

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.os.Environment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.google.zxing.BarcodeFormat
import com.google.zxing.MultiFormatWriter
import com.google.zxing.WriterException
import com.itextpdf.text.*
import com.itextpdf.text.pdf.PdfWriter
import com.itextpdf.text.pdf.draw.LineSeparator
import com.itextpdf.text.pdf.draw.VerticalPositionMark
import com.journeyapps.barcodescanner.BarcodeEncoder
import com.karumi.dexter.Dexter
import com.karumi.dexter.PermissionToken
import com.karumi.dexter.listener.PermissionDeniedResponse
import com.karumi.dexter.listener.PermissionGrantedResponse
import com.karumi.dexter.listener.PermissionRequest
import com.karumi.dexter.listener.single.PermissionListener
import com.udacoding.transactionpurchaseapp.R
import com.udacoding.transactionpurchaseapp.SessionManager
import com.udacoding.transactionpurchaseapp.room.model.EntityCart
import com.udacoding.transactionpurchaseapp.utils.*
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.CASH
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.payment_method.TRANSFER
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.PAID
import com.udacoding.transactionpurchaseapp.utils.Constant.Companion.transaction_status.QUOTATION
import com.udacoding.transactionpurchaseapp.view.home.home.ResultFileActivity
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataItemCompany
import com.udacoding.transactionpurchaseapp.view.home.home.model.DataTransaction
import com.zj.btsdk.BluetoothService
import com.zj.btsdk.PrintPic
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.dialog_print.*
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

@AndroidEntryPoint
class PrintDialogFragment(
    var data: List<EntityCart>?,
    var name_user: String,
    var name_customer: String,
    var telp: String,
    val data_transaction: DataTransaction?,
    val data_company: DataItemCompany
) : BottomSheetDialogFragment(),
    BluetoothHandler.HandlerInterface {

    private var is_Connect = false
    private var mService: BluetoothService? = null
    val RC_ENABLE_BLUETOOTH = 2
    val RC_CONNECT_BLUETOOTH = 3

    val file_name = "${data_transaction?.transactionCode}File.pdf"

    @Inject
    lateinit var session: SessionManager

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.dialog_print, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        mService = BluetoothService(activity, BluetoothHandler(this))

        Dexter.withActivity(activity)
            .withPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
            .withListener(object : PermissionListener {
                override fun onPermissionGranted(response: PermissionGrantedResponse?) {
                    btnViewPDF.setOnClickListener {
                        createPdfFile(
                            activity?.applicationContext?.let { it1 -> Common.getAppPath(it1) } +file_name
                        )
                    }
                }

                override fun onPermissionRationaleShouldBeShown(
                    permission: PermissionRequest?,
                    token: PermissionToken?
                ) {
                    TODO("Not yet implemented")
                }

                override fun onPermissionDenied(response: PermissionDeniedResponse?) {
                    TODO("Not yet implemented")
                }

            })
            .check()

        btnPrint.setOnClickListener {

            printData(data)

        }
    }

    private fun createPdfFile(path: String) {
        if (File(path).exists())
            File(path).delete()
        try {
            val document = Document()
            //save
            PdfWriter.getInstance(document, FileOutputStream(path))
            //open
            document.open()
            //setting
            document.apply {
                pageSize = PageSize.A4
                addCreationDate()
                addAuthor("Ido Legacy")
                addCreator("Ido Legacy")
            }

            //font setting
            val colorAccent = BaseColor(0, 153, 204, 225)
            val headingFontSize = 10.0f
            val valueFontSize = 13.0f

            //custom font
//            val fontName = BaseFont.createFont("assets/fonts/brandon.otf", "UTF-8",BaseFont.EMBEDDED)

            //title document
            val titleStyle = Font(Font.FontFamily.TIMES_ROMAN,13.0f,Font.NORMAL,BaseColor.BLACK)
            val titleStyleColorBlue = Font(Font.FontFamily.TIMES_ROMAN,13.0f,Font.NORMAL, colorAccent)
            addNewitem(document, data_company.companyName?.toUpperCase(Locale.ROOT) ?: "",
                Element.ALIGN_CENTER, titleStyleColorBlue)
            addLineSpace(document)

            val subTitleStyle = Font(Font.FontFamily.TIMES_ROMAN,10.0f,Font.NORMAL,BaseColor.BLACK)
            addNewitem(document, "Tel: "+data_company.companyTelp+" Email: "+data_company.companyEmail, Element.ALIGN_CENTER, subTitleStyle)
            addLineSpace(document)

            addNewitem(document, data_company.city?.cityName+", "+data_company.state?.stateName+", "+data_company.country?.countryName, Element.ALIGN_CENTER, subTitleStyle)
            addLineSpace(document)
            addLineSpace(document)
            addLineSpace(document)

            addNewitem(document, "Official E-Receipt", Element.ALIGN_CENTER, titleStyle)
            addLineSpace(document)
            addLineSpace(document)
            addLineSpace(document)

            if (session.quotation){
                val statusStyle = Font(Font.FontFamily.TIMES_ROMAN,12.0f,Font.BOLD, colorAccent)
                addNewitem(document, QUOTATION, Element.ALIGN_RIGHT, statusStyle)
            } else if (data_transaction?.paymentMethod == CASH || data_transaction?.paymentMethod == TRANSFER){
                val statusStyle = Font(Font.FontFamily.TIMES_ROMAN,12.0f,Font.BOLD, colorAccent)
                addNewitem(document, PAID, Element.ALIGN_RIGHT, statusStyle)
            }

            val headingStyle = Font(Font.FontFamily.TIMES_ROMAN,headingFontSize,Font.NORMAL,colorAccent)
            addNewitem(document, "Receipt No:", Element.ALIGN_LEFT, headingStyle)

            val valueStyle = Font(Font.FontFamily.TIMES_ROMAN,valueFontSize,Font.NORMAL,BaseColor.BLACK)
            addNewitem(document, "#${data_transaction?.transactionCode}", Element.ALIGN_LEFT, valueStyle)

            addLineSeparator(document)

            addNewitem(document, "Client Name:", Element.ALIGN_LEFT, headingStyle)
            addNewitem(document, name_customer, Element.ALIGN_LEFT, valueStyle)

            addLineSeparator(document)

            val date = Calendar.getInstance().time
            val df = SimpleDateFormat("dd-MM-yyyy HH:mm:SS", Locale.getDefault())
            val formattedDate: String = df.format(date)

            Log.d("TAG", "createPdfFile: date : $formattedDate")

//            addNewitem(document, "Date:", Element.ALIGN_LEFT, headingStyle)
//            addNewitem(document, formattedDate, Element.ALIGN_LEFT, valueStyle)

//            addLineSeparator(document)

//            addNewitem(document, "Customer Name:", Element.ALIGN_LEFT, headingStyle)
//            addNewitem(document, name_customer, Element.ALIGN_LEFT, valueStyle)
//
//            addLineSeparator(document)

            //Product Detail
            addLineSpace(document)
            addNewitem(document, "Product Details", Element.ALIGN_CENTER, titleStyle)

            addLineSeparator(document)

            //item1
            var total = 0.0
            for (i in data?.indices ?: 0..1){
                addNewItemWithLeftAndRight(document, "${data?.get(i)?.name_product} x ${data?.get(i)?.qty}", toRinggit(data?.get(i)?.total_item_price),titleStyle, valueStyle)
                total += data?.get(i)?.total_item_price ?: 0.0
            }
//            addNewItemWithLeftAndRight(document, "Pizza 25","(0.0%)",titleStyle, valueStyle)
//            addNewItemWithLeftAndRight(document, "12.0*1000","12000.0",titleStyle, valueStyle)

//            addLineSeparator(document)

            //item2
//            addNewItemWithLeftAndRight(document, "Pizza 26","(0.0%)",titleStyle, valueStyle)
//            addNewItemWithLeftAndRight(document, "12.0*1000","12000.0",titleStyle, valueStyle)

            addLineSeparator(document)

            //total
            addLineSpace(document)
            addLineSpace(document)

            if (session.quotation){
                addNewItemWithLeftAndRight(document, "Total", toRinggit(total),titleStyle, valueStyle)
            } else {
                addNewItemWithLeftAndRight(document, "Total", data_transaction?.paymentMethod+" "+toRinggit(total),titleStyle, valueStyle)
            }


            addLineSeparator(document)

            addNewitem(document, "Remarks:", Element.ALIGN_LEFT, headingStyle)
            addNewitem(document, data_transaction?.transactionNote ?: "", Element.ALIGN_LEFT, valueStyle)

            addLineSeparator(document)

            addNewitem(document, "Change Issued By:", Element.ALIGN_LEFT, headingStyle)
            addNewitem(document, name_user, Element.ALIGN_LEFT, valueStyle)
            addNewitem(document, formattedDate, Element.ALIGN_LEFT, valueStyle)

            //close
            document.close()

            session.quotation = false

            Toast.makeText(activity?.applicationContext, "Success generate pdf", Toast.LENGTH_SHORT).show()

            val intent = Intent(activity?.applicationContext, ResultFileActivity::class.java)
            intent.putExtra("path", path)
            intent.putExtra("phone", telp)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)

//            printPdf()

        } catch (e: Exception){
            Log.d("TAG", "createPdfFile: ${e.message}")
            Toast.makeText(activity?.applicationContext, "createPdfFile: ${e.message}", Toast.LENGTH_SHORT).show()
        }

    }

//    private fun printPdf() {
//        val printManager = activity?.getSystemService(Context.PRINT_SERVICE) as PrintManager
//        try {
//            val printAdapter = activity?.applicationContext?.let {
//                PdfDocumentAdapter(
//                    it,
//                    activity?.applicationContext?.let { Common.getAppPath(it) } + file_name)
//            }
//            printAdapter?.let {
//                printManager.print("Document",
//                    it, PrintAttributes.Builder().build())
//            }
//            Log.d("TAG", "printPdf: success")
//        } catch (e: Exception){
//            Log.d("TAG", "printPdf: ${e.message}")
//        }
//    }

    @Throws(DocumentException::class)
    private fun addNewItemWithLeftAndRight(document: Document, textLeft: String, textRight: String, leftStyle: Font, rightStyle: Font) {

        val chunkTextLeft = Chunk(textLeft, leftStyle)
        val chunkTextRight = Chunk(textRight, rightStyle)
        val p = Paragraph(chunkTextLeft)
        p.add(Chunk(VerticalPositionMark()))
        p.add(chunkTextRight)
        document.add(p)


    }

    @Throws(DocumentException::class)
    private fun addLineSeparator(document: Document) {
        val lineSeparator = LineSeparator()
        lineSeparator.lineColor = BaseColor(0,0,0,68)
        addLineSpace(document)
        document.add(Chunk(lineSeparator))
        addLineSpace(document)
    }

    @Throws(DocumentException::class)
    private fun addLineSpace(document: Document) {
        document.add(Paragraph(""))
    }

    @Throws(DocumentException::class)
    private fun addNewitem(document: Document, s: String, align: Int, style: Font) {
        val chunk = Chunk(s, style)
        val p = Paragraph(chunk)
        p.alignment = align
        document.add(p)

    }

    private fun printData(it: List<EntityCart>?) {
        if (is_Connect) {
            mService?.write(PrinterCommands.ESC_ENTER)
            mService?.write(PrinterCommands.ESC_ALIGN_CENTER)
            mService?.write(PrinterCommands.ESC_CANCEL_BOLD)
            mService?.sendMessage("TRANSACTION\n", "")
            mService?.sendMessage(formatDate(data_transaction?.createdAt), "")
            mService?.write(PrinterCommands.ESC_ENTER)
            mService?.sendMessage(data_company.companyName, "")
//            mService?.sendMessage("Lot 59, ground floor, Asia City (1.695,90 km)\n" +
//                    "Kota Kinabalu, Sabah, Malaysia 88000", "")
            mService?.sendMessage("Email: ${data_company.companyEmail}", "")
            mService?.sendMessage("Fax: ${data_company.companyFax}, Tel: ${data_company.companyTelp}", "")
            mService?.write(PrinterCommands.ESC_ALIGN_CENTER)
            var multiformatWriter = MultiFormatWriter()

            try {
                var bitMatrix = multiformatWriter.encode(data_transaction?.transactionCode ?: "", BarcodeFormat.QR_CODE, 200, 200)
                var barcodeEncoder = BarcodeEncoder()
                var bitmap = barcodeEncoder.createBitmap(bitMatrix)


                var pg = PrintPic()
                pg.initCanvas(200)
                pg.initPaint()
                pg.drawImage(0f, 0f, saveImageToExternalStorage(bitmap))
                var sendData = pg.printDraw()
                mService?.write(PrinterCommands.ESC_ALIGN_CENTER)
                mService?.write(sendData)


            } catch (e: WriterException) {
            }
            //mService?.write(PrinterCommands.ESC_ENTER)

            var BILL = ""


         //   mService?.write(PrinterCommands.ESC_CANCEL_BOLD)


            mService?.sendMessage("--------------------------------","")
            mService?.sendMessage(String.format("%-15s %5s %10s", "Item", "Qty","Price"), "")
            mService?.sendMessage("--------------------------------","")
            var total = 0.0
            for (i in it?.indices ?: 0..1){
                mService?.sendMessage(
                    String.format("%-18s %1s %10s", trySubString(it?.get(i)?.name_product ?: ""), it?.get(i)?.qty, it?.get(i)?.total_item_price),
                    ""
                )
                total += it?.get(0)?.total_item_price ?: 0.0

            }

            mService?.sendMessage("--------------------------------","")

           // BILL = BILL + "                 Total Pricr:" + "85" + "\n"
          //  BILL = BILL + "                Total Price:" + "${it?.get(0)?.total_item_price}" + "\n"
//            mService?.sendMessage(
//                String.format("%-15s %5s %10s", "Discount","", "0%"),
//                ""
//            )
            mService?.sendMessage(
                String.format("%-15s %5s %10s", "Total Price","", toRinggit(total)),
                ""
            )

           // mService?.sendMessage(BILL, "")
            mService?.write(PrinterCommands.ESC_ENTER)
            mService?.write(PrinterCommands.ESC_ENTER)
            mService?.write(PrinterCommands.ESC_ALIGN_CENTER)
            mService?.write(PrinterCommands.ESC_ALIGN_CENTER)

//            PRINT IMAGE

//            var pg = PrintPic();
//            pg.initCanvas(200);
//
//            pg.initPaint();
//
//
//            var bitmap = BitmapFactory.decodeResource(resources, R.drawable.ido)
//            pg.drawImage(10F, 0F, saveImageToExternalStorage(bitmap));
//            var sendData = pg.printDraw()
//            mService?.write(PrinterCommands.ESC_ALIGN_CENTER);
//            mService?.write(sendData)
//
//            mService?.write(PrinterCommands.ESC_ALIGN_CENTER)
//            mService?.write(PrinterCommands.ESC_CANCEL_BOLD)

//            END

            mService?.sendMessage("THANK YOU", "")
            mService?.write(PrinterCommands.ESC_ENTER)

        } else {
            if (mService?.isBTopen ?: true) {
                //kalaua blotot nyala bisa pilih blotot yang aktif
                var intent = Intent(activity, DeviceActivity::class.java)
                startActivityForResult(intent, RC_CONNECT_BLUETOOTH)
            } else {
                // kalao bt belum nyala req enable bt
                requestBluetooth()
            }

        }

    }
    private fun requestBluetooth() {
        if (mService != null) {
            if (mService?.isBTopen() == false) {
                val intent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                startActivityForResult(intent, RC_ENABLE_BLUETOOTH)
            }
        }
    }

    fun trySubString(msg : String) : String{
        var newReturn = ""
        if(msg.length > 14){

         newReturn =    msg.substring(8)
        }
        else{
            newReturn = msg
        }

        return newReturn
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)


            when (requestCode) {
                RC_ENABLE_BLUETOOTH -> if (resultCode == AppCompatActivity.RESULT_OK) {
                    message("onActivityResult: bluetooth aktif")
                } else
                    message("onActivityResult: bluetooth harus aktif untuk menggunakan fitur ini")
                RC_CONNECT_BLUETOOTH -> if (resultCode == AppCompatActivity.RESULT_OK) {
                    val address = data?.getExtras()!!.getString(DeviceActivity.EXTRA_DEVICE_ADDRESS)
                    val mDevice = mService?.getDevByMac(address)
                    mService?.connect(mDevice)
                }
            }

    }

    fun message(msg: String) {
        Toast.makeText(activity?.applicationContext, msg, Toast.LENGTH_SHORT).show()
    }


    private fun saveImageToExternalStorage(bitmap: Bitmap): String {
        // Get the external storage directory path
        val path = File(Environment.getExternalStorageDirectory().toString() + "/kebabalibaba")

        if (!path.exists()) {
            path.mkdirs()
        }


        // Create a file to save the image
        val file = File(path, "logo_struk.png")

        try {
            // Get the file output stream
            val stream = FileOutputStream(file)

            // Compress the bitmap
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)

            // Flush the output stream
            stream.flush()

            // Close the output stream
            stream.close()
        } catch (e: IOException) { // Catch the exception
            e.printStackTrace()
            Toast.makeText(activity, "Error load logo struk.", Toast.LENGTH_LONG).show()
        }

        // Return the saved image path to uri
        return file.absolutePath
    }


    override fun onDeviceConnected() {

        is_Connect = true
        message("Success connect to Printer")
        printData(data)

    }

    override fun onDeviceUnableToConnect() {
          message("Failed connect to Printer")
    }

    override fun onDeviceConnectionLost() {
          message("lose connect to Printer")
    }

    override fun onDeviceConnecting() {
          message(" connecting to Printer ....")
    }


}