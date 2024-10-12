import { motion, useViewportScroll, useTransform } from 'framer-motion';

export default function ScrollEffect() {
  const { scrollYProgress } = useViewportScroll(); // Captura a rolagem
  const scale = useTransform(scrollYProgress, [0, 1], [1, 2]); // Ajusta a escala conforme a rolagem

  return (
    <motion.div style={{ scale }}>
      <h1 style={{ textAlign: 'center', marginTop: '50vh' }}>Império Virtual</h1>
    </motion.div>
  );
}
