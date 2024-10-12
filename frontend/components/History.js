import { motion } from 'framer-motion';
import Link from 'next/link';
import AnimatedCharacter from '../components/AnimatedCharacter'; // Caminho ajustado
import Feedback from '../components/Feedback'; // Caminho ajustado

const fadeInUp = {
  initial: { opacity: 0, y: 60 },
  animate: { opacity: 1, y: 0 },
};

const staggerContainer = {
  initial: {},
  animate: {
    transition: {
      staggerChildren: 0.3,
    },
  },
};

export default function History() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 to-black text-white py-12 px-6 relative">
      <motion.div
        initial="initial"
        animate="animate"
        variants={staggerContainer}
        className="max-w-4xl mx-auto text-center"
      >
        <motion.h1
          variants={fadeInUp}
          className="text-5xl font-extrabold tracking-widest text-yellow-500"
        >
          Nossa História
        </motion.h1>
        <motion.p
          variants={fadeInUp}
          className="mt-6 text-lg leading-relaxed text-gray-300"
        >
          Desde 2020, a Império Bebidas e Tabacos tem sido uma referência em Campos Belos e região, entregando os melhores produtos e oferecendo produtos com qualidades impecáveis aos seus clientes.
          Nossa trajetória é marcada pela excelência, inovação e o compromisso de levar até você as bebidas e tabacos mais requintados.
        </motion.p>

        <motion.div variants={fadeInUp} className="mt-12">
          <video
            className="w-full rounded-lg shadow-lg"
            controls
            src="/videos/our-journey.mp4"
            alt="Vídeo da trajetória da empresa"
          />
        </motion.div>

        <motion.div variants={fadeInUp} className="mt-12">
          <h2 className="text-4xl font-bold text-yellow-500">Nossa Missão</h2>
          <p className="mt-4 text-lg leading-relaxed text-gray-300">
            Construir um império onde a qualidade, a confiança e a satisfação do cliente sejam as nossas principais conquistas. Desde a escolha dos produtos até a entrega, tratamos cada cliente como parte da nossa realeza.
          </p>
        </motion.div>

        <motion.div variants={fadeInUp} className="mt-12">
          <h2 className="text-4xl font-bold text-yellow-500">Nossos Valores</h2>
          <p className="mt-4 text-lg leading-relaxed text-gray-300">
            Inovação, compromisso e qualidade são os pilares que sustentam nosso império. Desde a fundação em 2020, trabalhamos incansavelmente para oferecer as melhores experiências para nossos clientes.
          </p>
        </motion.div>

        <motion.div variants={fadeInUp} className="mt-12">
          <h2 className="text-4xl font-bold text-yellow-500">O Futuro</h2>
          <p className="mt-4 text-lg leading-relaxed text-gray-300">
            O futuro é brilhante para a Império. Planejamos expandir ainda mais nossa presença e continuar a oferecer excelência e qualidade, criando experiências únicas para nossos clientes.
          </p>
        </motion.div>

        <motion.div variants={fadeInUp} className="mt-12">
          <Link href="/" legacyBehavior>
            <a className="text-lg font-semibold text-yellow-500 hover:text-yellow-400 transition duration-300">
              Voltar para a Página Inicial
            </a>
          </Link>
        </motion.div>
      </motion.div>

      {/* Componente de Feedback */}
      <motion.div
        initial={{ opacity: 0, y: -50 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6 }}
        className="mt-12 p-6 bg-white rounded-lg shadow-lg text-black"
      >
        <h2 className="text-3xl font-bold mb-4">Queresmos saber o que você achou da sua experiências na nossa platafroma.</h2>
        <Feedback />
      </motion.div>

      {/* Adicionando os personagens à página */}
      <div className="absolute bottom-0 left-0">
        <AnimatedCharacter character="beer" />
      </div>
      <div className="absolute bottom-0 right-0">
        <AnimatedCharacter character="soda" />
      </div>
    </div>
  );
}
