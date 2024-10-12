import { useEffect, useState } from 'react';
import Lottie from 'lottie-react';
import beerAnimation from '../public/animations/beerAnimation.json'; // Caminho ajustado
import sodaAnimation from '../public/animations/sodaAnimation.json'; // Caminho ajustado

export default function AnimatedCharacter({ character }) {
  const [animationData, setAnimationData] = useState(null);

  useEffect(() => {
    if (character === 'beer') {
      setAnimationData(beerAnimation);
    } else if (character === 'soda') {
      setAnimationData(sodaAnimation);
    }
  }, [character]);

  if (!animationData) {
    return <div>Carregando animação...</div>;
  }

  return (
    <div style={{ position: 'relative', width: '150px' }}>
      <Lottie animationData={animationData} loop={true} />
    </div>
  );
}
