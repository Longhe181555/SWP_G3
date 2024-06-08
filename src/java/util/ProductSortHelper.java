/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package util;

import entity.Product;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;


public class ProductSortHelper {
     public static ArrayList<Product> sortByPriceAscending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return Integer.compare(p1.getPrice(), p2.getPrice());
            }
        });
        return sortedProducts;
    }

    // Function to sort products by price in descending order
    public static ArrayList<Product> sortByPriceDescending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return Integer.compare(p2.getPrice(), p1.getPrice());
            }
        });
        return sortedProducts;
    }
    public static ArrayList<Product> sortByDateAscending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return p1.getDate().compareTo(p2.getDate());
            }
        });
        return sortedProducts;
    }

    // Function to sort products by date in descending order
    public static ArrayList<Product> sortByDateDescending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return p2.getDate().compareTo(p1.getDate());
            }
        });
        return sortedProducts;
    }
    public static ArrayList<Product> getFirstSixElements(ArrayList<Product> products) {
        if (products.size() <= 6) {
            return products;
        } else {
            return new ArrayList<>(products.subList(0, 6));
        }
    }
     // New method to sort products by rating in ascending order
    public static ArrayList<Product> sortByRatingAscending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return Float.compare(p1.getAvarageRating(), p2.getAvarageRating());
            }
        });
        return sortedProducts;
    }

    // New method to sort products by rating in descending order
    public static ArrayList<Product> sortByRatingDescending(ArrayList<Product> products) {
        ArrayList<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts, new Comparator<Product>() {
            @Override
            public int compare(Product p1, Product p2) {
                return Float.compare(p2.getAvarageRating(), p1.getAvarageRating());
            }
        });
        return sortedProducts;
    }
    public static ArrayList<Product> filterByPriceRange(ArrayList<Product> products, Integer minPrice, Integer maxPrice) {
        ArrayList<Product> filteredProducts = new ArrayList<>();
        
        for (Product product : products) {
            boolean matchesPrice = true;

            if (minPrice != null) {
                matchesPrice = product.getPrice() >= minPrice;
            }

            if (maxPrice != null) {
                matchesPrice = matchesPrice && product.getPrice() <= maxPrice;
            }

            if (matchesPrice) {
                filteredProducts.add(product);
            }
        }
        
        return filteredProducts;
}
    
    
    public static ArrayList<Product> filterByRating(ArrayList<Product> products, float minRating) {
        ArrayList<Product> filteredProducts = new ArrayList<>();
        
        for (Product product : products) {
            if (product.getAvarageRating() > minRating) {
                filteredProducts.add(product);
            }
        }
        
        return filteredProducts; 
}
    
     public static ArrayList<Product> haveDiscount(ArrayList<Product> products) {
    ArrayList<Product> filteredProducts = new ArrayList<>();

    for (Product product : products) {
        if (product.getDiscountDescription() != null) {
            filteredProducts.add(product);
        }
    }

    return filteredProducts;
}
}
