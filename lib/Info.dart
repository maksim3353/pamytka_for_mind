import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/LocalRulesProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class InfoScr extends StatefulWidget {
  const InfoScr({super.key});

  @override
  State<InfoScr> createState() => _InfoScrState();
}

class _InfoScrState extends State<InfoScr> {


final  TEC = TextEditingController();




  Future<bool> _CConfirmDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          title: Text(
            "Вы уверены?",
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            "Вы действительно хотите ?",
            style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                "отмена",
                style: const TextStyle(
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                "подтвердить",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<bool> _ConfirmDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          title: Text(
            "Удалить ВСЕ правила?",
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            "Вы действительно хотите удалить все правила?",
            style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                "отмена",
                style: const TextStyle(
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                "удалить",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = context.read<LocalRulesProvider>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(size.width * 0.02),
          children: [
            GestureDetector(
              onTap: () async {
                final t = await _ConfirmDialog(context);

                if (!t) return;
                final ta = await _CConfirmDialog(context);

                if (!ta) return;

                await provider.DeleteAll();
              },
              child: Container(
                height: size.height * 0.07,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 50, 50),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color.fromARGB(80, 255, 255, 255),
                  ),
                ),
                child: Text(
                  'Удалить все правила',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.01),

            GestureDetector(
              onTap: () async {




                final getted = await provider.GetJsonRules();

                await Clipboard.setData(ClipboardData(text: getted.toString()));


                if (!mounted) return;
                ScaffoldMessenger.of(


                  context,

                ).showSnackBar(const SnackBar(content: Text('Скопировано')));



              },









              child: Container(
                height: size.height * 0.07,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 49, 49, 49),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color.fromARGB(57, 255, 255, 255),
                  ),
                ),
                child: Text(
                  'Скопировать JSON ваших правил',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.012,),

Container(
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 49, 49, 49),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color.fromARGB(57, 255, 255, 255),
                  ),
                ),
  child: Column(
    children: [
      TextField(
        controller: TEC,
        maxLines: 5,
cursorColor: Colors.white,


        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(

          
          hintText: 'Введите сюда ваш JSON, для перенесения ваших правил в приложение(ваши старые правила будут удалены)',
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          
          fillColor: Color.fromARGB(255, 38, 38, 38),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),


      ),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
backgroundColor: WidgetStatePropertyAll(Colors.white),
textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black))

          ),
          onPressed: () async {

            final text = TEC.text.trim();
            if (text.isEmpty) return;

           final ff=  await _CConfirmDialog(context);
if (!ff) return;

            final p =  await provider.SaveFromList(text);
      
          },
          child: const Text('Удалить и добавить правила',style: TextStyle(color: Colors.black),),
        ),
      ),
    ],
  ),
),


          ],
        ),
      ),
    );
  }
}
