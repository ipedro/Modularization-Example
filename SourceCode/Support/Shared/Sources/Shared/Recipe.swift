import UIKit

public enum Recipe: String, Hashable, CaseIterable {
    case chickenMarsala = """
    Chicken Marsala

    Chicken Marsala is an Italian-American dish of golden pan-fried chicken cutlets and mushrooms in a rich Marsala wine sauce.

    Servings: 4
    Prep Time: 15 Minutes
    Cook Time: 30 Minutes
    Total Time: 45 Minutes
    """

    case penne = """
    Penne alla Vodka

    Penne alla vodka, or penne with a bright tomato sauce enriched with heavy cream, makes a quick, family-friendly dinner.

    Servings: 4 to 6
    Prep Time: 15 Minutes
    Cook Time: 30 Minutes
    Total Time: 45 Minutes
    """

    case pumpkinSoup = """
    Pumpkin Soup

    Flavored with leeks, maple syrup and spices, this pumpkin soup is the ultimate fall comfort food.

    Servings: 6
    Prep Time: 15 Minutes
    Cook Time: 30 Minutes
    Total Time: 45 Minutes
    """

    case applePie = """
    Apple Pie

    With a crisp, flaky crust and thick, cider-flavored apple filling, this is my idea of the perfect apple pie.

    Servings: 8
    Prep Time: 30 Minutes
    Cook Time: 60 Minutes
    Total Time: 90 Minutes
    """

    case couscous = """
    Couscous

    Couscous is made from tiny steamed balls of semolina flour. Though we think of it as a grain, it’s actually a type of pasta.

    Servings: 4 - 6
    Prep Time: 5 Minutes
    Cook Time: 5 Minutes
    Total Time: 10 Minutes
    """

    public var title: String { rawValue }
}
