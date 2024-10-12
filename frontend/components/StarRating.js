import { motion } from 'framer-motion';
import { FaStar } from 'react-icons/fa';

export default function StarRating({ initialRating = 0, onRatingChange = () => {}, isFixed = false }) {
  const handleStarClick = (ratingValue) => {
    if (!isFixed) {
      onRatingChange(ratingValue);
    }
  };

  return (
    <div className="star-rating" role="radiogroup" aria-label="Star Rating">
      {[...Array(5)].map((_, index) => {
        const ratingValue = index + 1;
        return (
          <motion.label
            key={index}
            whileHover={!isFixed ? { scale: 1.3, rotate: 10 } : {}}
            whileTap={!isFixed ? { scale: 0.9 } : {}}
            className="star"
            onClick={() => handleStarClick(ratingValue)}
            aria-label={`Rating ${ratingValue}`}
          >
            <input
              type="radio"
              name="rating"
              value={ratingValue}
              className="hidden"
              disabled={isFixed}
              checked={ratingValue === initialRating}
              readOnly={isFixed}
            />
            <FaStar
              size={40}
              color={ratingValue <= initialRating ? '#00FFFF' : '#333'}
              style={{
                filter:
                  ratingValue <= initialRating
                    ? 'drop-shadow(0px 0px 10px #00FFFF) drop-shadow(0px 0px 5px black)'
                    : 'none',
              }}
            />
          </motion.label>
        );
      })}
    </div>
  );
}
