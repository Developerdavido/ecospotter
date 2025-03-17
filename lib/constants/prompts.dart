
class Prompts {

  ///this will return a string that will be used to make the initial prompt
  static String triviaQuestions({String? specieName, String? occupation}) {
    return ''' "Generate a set of 8 general knowledge questions about the animal species based on the following JSON parameters,
{"name": $specieName,
"level": $occupation,}.
The questions must be of JSON format with the following structure {"questions":[
{
"question":\$question,
"answers": \$answers,
"correctAnswer":\$correctAnswer
}
]
}.
The \$question value must be a string,
The \$answers value must be a list of string with only 4 options and one correct answer to the question
The \$correctAnswer value must be a string"''';
  }


  //this prompt will make a call to get the detail information of the species
  static String moreInfo({String? specieName}) {
    return ''' "Generate some interesting trivia of not more than 150 words about the animal species based on the following JSON parameters,
{"name": $specieName}.
The questions must be of JSON format with the following structure 
{
"description":\$description,
}
The \$image value must be a string"''';
  }
}


Map<int, dynamic> alphabetMap = {
  0 : "a)",
  1 : "b)",
  2 : "c)",
  3 : "d)",
  4 : "e)",
  5 : "f)",
  6 : "g)",
};

Map<String, dynamic> dummyPayload = {
  "questions": [
    {
      "subject": "Physics",
      "question": "Explain the concept of superposition in quantum mechanics and provide an example of a physical phenomenon that demonstrates it.",
      "answers": [
        "Superposition is the principle that a quantum system can exist in multiple states simultaneously. For example, a photon can be polarized both horizontally and vertically at the same time, until measured.",
        "Superposition allows for quantum systems to be in a linear combination of states, where the probabilities of each state are defined by their coefficients.",
        "Superposition is a key concept in quantum computing, enabling the development of algorithms that exploit the superposition of qubits to solve complex problems more efficiently than classical computers."
      ]
    },
    {
      "subject": "Chemistry",
      "question": "Describe the mechanism of a SN1 reaction and explain the factors that influence its rate.",
      "answers": [
        "An SN1 reaction proceeds through a carbocation intermediate, which is formed by the ionization of the substrate. The rate of the reaction is determined by the stability of the carbocation.",
        "Factors that influence the rate of an SN1 reaction include the stability of the carbocation, the nature of the leaving group, the polarity of the solvent, and the concentration of the reactants.",
        "Examples of SN1 reactions include the hydrolysis of tertiary alkyl halides and the solvolysis of tertiary alcohols."
      ]
    },
    {
      "subject": "Biology",
      "question": "Discuss the role of the enzyme DNA polymerase in DNA replication and describe its different activities.",
      "answers": [
        "DNA polymerase is a key enzyme in DNA replication, responsible for synthesizing new DNA strands using a pre-existing template strand.",
        "DNA polymerase has multiple activities, including 5' to 3' polymerase activity, 3' to 5' exonuclease activity for proofreading, and 5' to 3' exonuclease activity for removing primer sequences.",
        "The accuracy of DNA replication is ensured by the proofreading activity of DNA polymerase, which reduces the frequency of mutations."
      ]
    },
    {
      "subject": "Mathematics",
      "question": "Explain the concept of a limit in calculus and provide an example of how it is used to define continuity.",
      "answers": [
        "The limit of a function as x approaches a specific value is the value that the function approaches as x gets closer and closer to that value.",
        "Continuity at a point is defined in terms of limits: a function is continuous at a point if the limit as x approaches that point exists and is equal to the value of the function at that point.",
        "The concept of limits is fundamental in calculus and is used to define derivatives, integrals, and other important concepts."
      ]
    },
    {
      "subject": "Computer Science",
      "question": "Explain the difference between a stack and a queue and provide examples of how these data structures are used in real-world applications.",
      "answers": [
        "A stack is a LIFO (Last In First Out) data structure, while a queue is a FIFO (First In First Out) data structure.",
        "Stacks are used in function calls, undo/redo functionality in software, and evaluating mathematical expressions.",
        "Queues are used in scheduling tasks, handling requests in a server, and managing data in a print spooler."
      ]
    }
  ]
};