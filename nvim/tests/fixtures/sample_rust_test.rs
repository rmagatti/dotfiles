// Sample Rust file with test modules for testing the folding utility

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

pub fn multiply(a: i32, b: i32) -> i32 {
    a * b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 2), 4);
        assert_eq!(add(-1, 1), 0);
    }

    #[test]
    fn test_add_negative() {
        assert_eq!(add(-5, -3), -8);
    }

    #[test]
    fn test_multiply() {
        assert_eq!(multiply(3, 4), 12);
        assert_eq!(multiply(0, 5), 0);
    }

    #[test]
    fn test_multiply_negative() {
        assert_eq!(multiply(-2, 3), -6);
    }
}

pub struct Calculator {
    value: i32,
}

impl Calculator {
    pub fn new(value: i32) -> Self {
        Calculator { value }
    }

    pub fn add(&mut self, n: i32) {
        self.value += n;
    }

    pub fn get_value(&self) -> i32 {
        self.value
    }
}

#[cfg(test)]
mod calculator_tests {
    use super::*;

    #[test]
    fn test_calculator_new() {
        let calc = Calculator::new(10);
        assert_eq!(calc.get_value(), 10);
    }

    #[test]
    fn test_calculator_add() {
        let mut calc = Calculator::new(5);
        calc.add(3);
        assert_eq!(calc.get_value(), 8);
    }

    #[test]
    fn test_calculator_add_negative() {
        let mut calc = Calculator::new(10);
        calc.add(-5);
        assert_eq!(calc.get_value(), 5);
    }
}
