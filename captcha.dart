import 'dart:math';

import 'package:flutter/material.dart';

class Captcha extends StatefulWidget {
  double lebar, tinggi;
  int jumlahTitikMaks = 10;

  var stokWarna = {
    'merah': Color(0xa9ec1c1c),
    'hijau': Color(0xa922b900),
    'hitam': Color(0xa9000000),
  };
  var warnaTerpakai = {};
  String warnaYangDitanyakan = 'merah';

  Captcha(this.lebar, this.tinggi);

  @override
  State<StatefulWidget> createState() => _CaptchaState();

  bool benarkahJawaban(jawaban) {
    return false;
  }
}

class _CaptchaState extends State<Captcha> {
  var random = Random();

  @override
  void initState() {
    super.initState();
    buatPertanyaan();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: widget.lebar,
            height: widget.tinggi,
            child: CustomPaint(
              painter: CaptchaPainter(widget),
            ),
          ),
          Text(
            'Berapa jumlah titik warna ${widget.warnaYangDitanyakan}?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, height: 2),
          ),
        ],
      ),
    );
  }

  void buatPertanyaan() {
    setState(() {
      widget.warnaYangDitanyakan = widget.stokWarna.keys.elementAt(random.nextInt(3));
    });
  }
}

class CaptchaPainter extends CustomPainter {
  Captcha captcha;
  var random = Random();

  CaptchaPainter(this.captcha);

  @override
  void paint(Canvas canvas, Size size) {
    var catBingkai = Paint()
      ..color = Color(0xFF000000)
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Offset(0, 0) & Size(captcha.lebar, captcha.tinggi), catBingkai);

    captcha.stokWarna.forEach((key, value) {
      var jumlah = random.nextInt(captcha.jumlahTitikMaks + 1);
      if (jumlah == 0) jumlah = 1;
      captcha.warnaTerpakai[key] = jumlah;

      for (var i = 0; i < jumlah; i++) {
        var catTitik = Paint()
          ..color = value
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(
            random.nextDouble() * captcha.lebar,
            random.nextDouble() * captcha.tinggi),
            6, catTitik);
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}