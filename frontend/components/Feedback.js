// components/Feedback.js

import { useState } from 'react';
import { motion } from 'framer-motion';
import StarRating from './StarRating'; // Importando o componente de estrelas

export default function Feedback() {
  const [feedback, setFeedback] = useState('');
  const [rating, setRating] = useState(0);
  const [submittedFeedbacks, setSubmittedFeedbacks] = useState([]);
  const [submitted, setSubmitted] = useState(false);

  // Função para atualizar o rating quando uma estrela for clicada
  const handleRating = (value) => {
    setRating(value);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (feedback.trim()) {
      const newFeedback = { text: feedback, rating: rating };
      setSubmittedFeedbacks([newFeedback, ...submittedFeedbacks]);
      setFeedback('');
      setRating(0);
      setSubmitted(true);
      setTimeout(() => setSubmitted(false), 3000); // Mensagem temporária
    }
  };

  const fadeInDown = {
    hidden: { opacity: 0, y: -50 },
    visible: { opacity: 1, y: 0 },
  };

  return (
    <>
      <motion.div
        initial="hidden"
        animate="visible"
        variants={fadeInDown}
        transition={{ duration: 0.6 }}
        className="feedback-container" // Classe ajustada
      >
        <h2 className="feedback-heading text-2xl font-bold mb-4">Deixe seu Feedback</h2>
        {submitted ? (
          <p className="text-green-600">Obrigado pelo seu feedback!</p>
        ) : (
          <form onSubmit={handleSubmit}>
            <textarea
              className="w-full p-4 mb-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500 text-gray-800"
              rows="4"
              placeholder="Deixe aqui seu comentário..."
              value={feedback}
              onChange={(e) => setFeedback(e.target.value)}
            />
            <div className="mb-4">
              <p className="text-lg font-semibold text-gray-800">Dê uma nota para nós:</p>
              <StarRating initialRating={rating} onRatingChange={handleRating} /> {/* Passando a função handleRating */}
            </div>
            <button
              type="submit"
              className="bg-yellow-500 text-white px-6 py-2 rounded-full hover:bg-yellow-600 transition duration-300"
            >
              Enviar
            </button>
          </form>
        )}
      </motion.div>

      {/* Exibir Comentários Submetidos */}
      <motion.div
        initial="hidden"
        animate="visible"
        variants={fadeInDown}
        transition={{ duration: 0.6, delay: 0.3 }}
        className="feedback-container" // Classe ajustada
      >
        <h2 className="feedback-heading text-2xl font-bold mb-4">Comentários dos Clientes</h2>
        {submittedFeedbacks.length > 0 ? (
          submittedFeedbacks.map((item, index) => (
            <div key={index} className="mb-4 p-4 border border-gray-300 rounded-lg">
              <p className="text-gray-800 mb-2">{item.text}</p>
              <StarRating initialRating={item.rating} isFixed /> {/* Exibindo as estrelas fixas */}
            </div>
          ))
        ) : (
          <p className="text-gray-800">Nenhum comentário ainda. Seja o primeiro a comentar!</p>
        )}
      </motion.div>
    </>
  );
}

