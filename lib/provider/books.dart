import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'book_model.dart';

class Books with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Book> _books = [
    Book(
      id: "01",
      title: "Think Like a Monk",
      description:
          "Jay Shetty, the social media superstar and host of the #1 podcast ‘On Purpose’, distills the timeless wisdom he learned as a practicing monk into practical steps anyone can take every day to live a less anxious, more meaningful life.",
      price: 1990.0,
      imageUrl: "https://jumpbooks.lk/onojyglu/2020/10/Think-Like-a-Monk.jpg",
    ),
    Book(
      id: "02",
      title: "Rich Dad Poor Dad",
      description:
          "Rich Dad Poor Dad is the only book you need to know about personal finance. If you have not read a single book about finance or investing, Rich Dad Poor Dad is the best book to start with. It explains everything you need to know about money, personal finance and investing",
      price: 1990.0,
      imageUrl: "https://jumpbooks.lk/onojyglu/2017/03/rich-dad-poor-dad-1.jpg",
    ),
    Book(
      id: "03",
      title: "The Secret",
      description:
          "In 2006, a groundbreaking feature-length film revealed the great mystery of the universe—The Secret—and, later that year, Rhonda Byrne followed with a book that became a worldwide bestseller. Fragments of a Great Secret have been found in the oral traditions, in literature, in religions and philosophies throughout the centuries",
      price: 2290.0,
      imageUrl: "https://jumpbooks.lk/onojyglu/2019/11/The-Secret.jpg",
    ),
    Book(
      id: "04",
      title: "Zero to One",
      description:
          "The book recalls how certain innovative ideas were incubated and how people behind them dared to dream big and even did realize some of them. But trying to replicate or improvise what Bill Gates achieved with developing an operating system or what Large Page got out of making a user friendly search engine is not going to help in realizing the dream for building the next global business empire",
      price: 2290.0,
      imageUrl: "https://jumpbooks.lk/onojyglu/2017/03/Zero-to-one.jpg",
    ),
    Book(
      id: "05",
      title: "The Universe Has Your Back",
      description:
          "New York Times best-selling author offers simple prayers, affirmations, and exercises to support readers in releasing old thought systems and fears, and a return to peace.",
      imageUrl:
          "https://jumpbooks.lk/onojyglu/2021/07/The-Universe-Has-Your-Back.jpeg",
      price: 1490.0,
    ),
    Book(
      id: "06",
      title: "Relentless",
      description:
          "For more than two decades, legendary trainer Tim Grover has taken the greats—Michael Jordan, Kobe Bryant, Dwyane Wade, and hundreds of relentless competitors in sports, business, and every walk of life—and made them greater. Now, for the first time ever, he reveals what it takes to achieve total mental and physical dominance, showing you how to be relentless and achieve whatever you desire.",
      imageUrl: "https://jumpbooks.lk/onojyglu/2022/01/Relentless.jpeg",
      price: 1890.0,
    ),
    Book(
      id: "07",
      title: "Dusk, Night, Dawn",
      description:
          "In Dusk, Night, Dawn, Anne Lamott explores the tough questions that many of us grapple with. How can we recapture the confidence we once had as we stumble through the dark times that seem increasingly bleak? As bad newspiles up—from climate crises to daily assaults on civility—how can we cope? Where, she asks, “do we start to get our world and joy and hope and our faith in life itself back . . . with our sore feet, hearing loss, stiff fingers, poor digestion, stunned minds, broken hearts?”",
      imageUrl: "https://jumpbooks.lk/onojyglu/2022/01/Dusk-Night-Dawn.jpeg",
      price: 2190.0,
    ),
    Book(
      id: "08",
      title: "Layered Money",
      description:
          "In this fascinating deep dive into the evolution of monetary systems around the globe, Nik Bhatia takes us into the origins of how money has evolved to function in a “layered” manner. Using gold as an example of this term, he traces the layers of this ancient currency from raw mined material, to gold coins, and finally to bank-issued gold certificates.",
      imageUrl: "https://jumpbooks.lk/onojyglu/2021/12/Layered-Money.jpeg",
      price: 4690.0,
    ),
    Book(
      id: "09",
      title: "The Bogleheads’ Guide to Investing",
      description:
          "The Boglehead’s Guide to Investing is a DIY handbook that espouses the sage investment wisdom of John C. Bogle. This witty and wonderful book offers contrarian advice that provides the first step on the road to investment success, illustrating how relying on typical “common sense” promoted by Wall Street is destined to leave you poorer.",
      imageUrl:
          "https://jumpbooks.lk/onojyglu/2021/12/The-Bogleheads-Guide-to-Investing-.jpeg",
      price: 5490.0,
    ),
    Book(
      id: "10",
      title: "Paths to Wealth Through Common Stocks",
      description:
          "Paths to Wealth through Common Stocks contains one original concept after another, each designed to greatly improve the results of those who self-manage their investments — while helping those who rely on professional investment advice select the right advisor for their needs.",
      imageUrl:
          "https://jumpbooks.lk/onojyglu/2021/12/Paths-to-Wealth-Through-Common-Stocks.jpeg",
      price: 5690.0,
    ),
    Book(
      id: "11",
      title: "What Color Is Your Parachute? 2021",
      description:
          "With timeless advice, up-to-the-minute insights, and more than ten million copies sold over fifty years, the world’s most popular and best-selling career guide is fully revised and expanded for 2021.",
      imageUrl:
          "https://jumpbooks.lk/onojyglu/2021/10/What-Color-Is-Your-Parachute-2021.jpeg",
      price: 2590.00,
    ),
    Book(
      id: "12",
      title: "The Magic of Thinking Big",
      description:
          "More than 6 million readers around the world have improved their lives by reading The Magic of Thinking Big. First published in 1959, David J Schwartz’s classic teachings are as powerful today as they were then. Practical, empowering and hugely engaging, this book will not only inspire you, it will give you the tools to change your life for the better – starting from now.",
      imageUrl:
          "https://jumpbooks.lk/onojyglu/2017/06/The-magic-of-thinking-big.jpg",
      price: 1990.0,
    ),
    Book(
      id: "13",
      title: "Seneca",
      description:
          "It is philosophy that has the duty of protecting us…without it no one can lead a life free of fear or worry.",
      imageUrl: "https://jumpbooks.lk/onojyglu/2017/09/seneca.jpg",
      price: 1690.0,
    ),
    Book(
      id: "14",
      title: "Eat That Frog!",
      description:
          "This book, ‘Eat That Frog’ is one of the most influential self-help books in the world. It contains essays that motivate and influence the readers to avoid procrastination. Time management also happens to be an important part of the book. The chapters in the book have been given in such a manner that they will not consume excess of your time.",
      imageUrl: "https://jumpbooks.lk/onojyglu/2017/03/eat-that-frog-1.jpg",
      price: 1290.0,
    ),
    Book(
      id: "15",
      title: "Quiet ",
      description:
          "Quiet: The power of introverts in a world that can’t stop talking’ by Susa Cain is a Kick-starter of the quiet revolution and talks about all successful introverts. In today’s world where everyone has a lot to say, silence is quintessential and that is exactly what this book wants to convey.",
      imageUrl: "https://jumpbooks.lk/onojyglu/2017/08/quiet.jpg",
      price: 2090.0,
    )
  ];

  List<Book> get books {
    return [..._books];
  }

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  Book findById(String Id) {
    return _books.firstWhere((book) => book.id == Id);
  }

  //-------------for admin
  // final BookController _bookController = BookController();
  final ImagePicker _picker = ImagePicker();
  File _image = File("");

  File get getImage => _image;

  Future<void> selectImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
      } else {
        Logger().e("No Image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
// save book info loader

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // save book info
  void setIsLOading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Future<void> startSaveBookInfo(
  //     BuildContext context, String title, String desc, String price) async {
  //   // try {
  //   //setloading
  //   setIsLOading(true);
  //   await _bookController.saveBookInfo(
  //       title, desc, double.parse(price), _image);
  //   setIsLOading(false);
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.ERROR,
  //     animType: AnimType.BOTTOMSLIDE,
  //     title: 'Sucess',
  //     desc: 'Book Info saved sucessfull',
  //     btnOkOnPress: () {},
  //   ).show();
  //   Logger().i("Book is Saved");
  //   // } catch (e) {
  //   //   Logger().e(e);
  //   //   setIsLOading(false);
  //   // }
  // }
}
