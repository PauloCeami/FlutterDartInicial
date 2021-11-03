# agenda_contatos_sqflite

agenda de contatos e persistencia de dados

**Aula 92**
- Introdução e apresentação do app

**Aula 93**
- Versões dos plugins instalados
--- sqflite: ^2.0.0+4 (https://pub.dev/packages/sqflite/install)
--- url_launcher: ^6.0.12 (https://pub.dev/packages/url_launcher)
--- image_picker: ^0.8.4+4 (https://pub.dev/packages/image_picker/install)

**Aula 94**
- criando a classe de modelo do contato
- criando a inicialização do db como um helper do contato

**Aula 95**
- criando a classe helper DB
- criando a instancia do db
- criando tabela de contato 

**Aula 96**
- criando metodos de crud DAO

**Aula 97**
- criando metodos de crud DAO 

**Aula 98**
- testando metodos insert initstate

**Aula 99**
- criando ListView.builder
- criando floatingActionButton

**Aula 100**

**Aula 101**

**Aula 102**

**Aula 103**

**Aula 104**

**Aula 105**

**Aula 106**
- showModalBottomSheet  escolhendo entre opções 
em uma janela modal no bottom

**Aula 107**
ImagePicker agora suporta Galeria!
No próximo vídeo, eu disse que o ImagePicker ainda não suportava a Galeria, mas isso não é mais verdade! 
Agora o plugin suporta perfeitamente e eu mostrarei como criar uma janela pra escolher entre um ou outro lá no App #12!

**Aula 108**
- https://johannesmilke.teachable.com/p/intellij-super-efficient-with-flutter
- https://github.com/JohannesMilke/image_picker_example
- usando image picker 9 de ago. de 2021
- https://www.youtube.com/watch?v=MSv38jO4EJk&ab_channel=JohannesMilke

for ios
<project root>/ios/Runner/Info.plist

<key>NSCameraUsageDescription</key>
<string>describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.</string>
<key>NSMicrophoneUsageDescription</key>
<string>describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.</string>

decoration: BoxDecoration(
shape: BoxShape.circle,
image: DecorationImage(
image: mContatoEditing!.img != null
? FileImage(File(mContatoEditing!.img.toString()))
: AssetImage("images/person.png") as ImageProvider,
fit: BoxFit.cover,
),
)


**Aula 109**

**Aula 110**

**Aula 111**

**Aula 112**









## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



