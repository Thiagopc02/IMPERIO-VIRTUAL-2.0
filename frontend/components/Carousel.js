import { useState } from 'react';
import Image from 'next/image';

const slides = [
  { id: 1, image: '/images/c2.png', alt: 'Oferta 1' },
  { id: 2, image: '/images/Instagram Carrosel.png', alt: 'Oferta 2' },
  { id: 3, image: '/images/Amor.png', alt: 'Oferta 3' },
];

export default function Carousel() {
  const [currentSlide, setCurrentSlide] = useState(0);

  const nextSlide = () => {
    setCurrentSlide((prev) => (prev === slides.length - 1 ? 0 : prev + 1));
  };

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev === 0 ? slides.length - 1 : prev - 1));
  };

  return (
    <div className="relative w-full max-w-2xl mx-auto mt-8 flex flex-col items-center">
      <div className="overflow-hidden rounded-lg shadow-lg" style={{ width: '800px', height: '400px' }}>
        <div className="relative h-64 md:h-80 lg:h-96">
          <Image
            src={slides[currentSlide].image}
            alt={slides[currentSlide].alt}
            fill
            style={{ objectFit: 'cover' }} // Ajustando o estilo para o novo padrão
            className="transition-transform duration-700 ease-in-out transform hover:scale-105"
          />
          <div className="absolute top-4 left-4">
            <img src="/images/logo.png" alt="Império Logo" className="h-16 md:h-20 lg:h-24 opacity-80" />
          </div>
        </div>
      </div>

      <div className="flex mt-4 space-x-2">
        {slides.map((slide, index) => (
          <button
            key={slide.id}
            onClick={() => setCurrentSlide(index)}
            className={`w-3 h-3 rounded-full ${
              currentSlide === index ? 'bg-blue-600' : 'bg-gray-300'
            }`}
          />
        ))}
      </div>

      <button
        onClick={prevSlide}
        className="absolute left-4 top-1/2 transform -translate-y-1/2 bg-yellow-500 bg-opacity-80 text-white p-2 rounded-full hover:bg-yellow-600 transition-colors duration-300"
      >
        <img src="/images/Caro2.png" alt="Prev" className="h-8 w-8" />
      </button>
      <button
        onClick={nextSlide}
        className="absolute right-4 top-1/2 transform -translate-y-1/2 bg-yellow-500 bg-opacity-80 text-white p-2 rounded-full hover:bg-yellow-600 transition-colors duration-300"
      >
        <img src="/images/Caro1.png" alt="Next" className="h-8 w-8" />
      </button>
    </div>
  );
}
