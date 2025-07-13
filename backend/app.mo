import Text "mo:base/Text";
import Array "mo:base/Array";

actor {

  // Tipe pertanyaan-jawaban
  type QA = {
    question : Text;
    answer : Text;
  };

  // Variabel stable
  stable var qas : [QA] = [
    { question = "Apa dasar negara Indonesia?"; answer = "Pancasila" },
    { question = "Siapa presiden pertama Indonesia?"; answer = "Ir. Soekarno" },
    { question = "Apa semboyan negara Indonesia?"; answer = "Bhinneka Tunggal Ika" }
  ];

  // Fungsi mengambil semua pertanyaan
  public query func getQuestions() : async [Text] {
    Array.map<QA, Text>(qas, func (qa) { qa.question });
  };

  // Fungsi menjawab pertanyaan berdasarkan teks (dengan normalisasi)
  public query func answerQuestion(q : Text) : async ?Text {
    let normalizedInput = Text.toLowercase(Text.trim(q, #char ' '));
    let found : ?QA = Array.find<QA>(qas, func (qa) {
      Text.equal(
        Text.toLowercase(Text.trim(qa.question, #char ' ')),
        normalizedInput
      )
    });

    switch (found) {
      case (?qa) ?qa.answer;
      case null null;
    }
  };

  // Fungsi menambah pertanyaan dan jawaban baru
  public func addQA(q : Text, a : Text) : async () {
    let newQA : QA = { question = q; answer = a };
    qas := Array.append<QA>(qas, [newQA]);
  };
}