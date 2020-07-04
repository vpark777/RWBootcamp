/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CompactViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let pokemons = PokemonGenerator.shared.generatePokemons()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    /*
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width:120, height:120)
    collectionView.collectionViewLayout = layout
    */
    collectionView.collectionViewLayout = configureLayout()
    
    collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "myCell" )
    collectionView.delegate = self
    collectionView.dataSource = self
        // Do any additional setup after loading the view.
    for pokemon in pokemons {
      print("pokemon ID:\(pokemon.pokemonID) name: \(pokemon.pokemonName)")
    }
 }//viewDidLoad
  

  func configureLayout()->UICollectionViewCompositionalLayout
  {
     // let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.30) , heightDimension: .absolute(120))
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25) , heightDimension: .fractionalWidth(0.25))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(5.0),top: .fixed(10.0),trailing: .flexible(5.0),bottom:.fixed(10.0))
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                           heightDimension: .estimated(120))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
     
    
      let section = NSCollectionLayoutSection(group:group)
   //section.interGroupSpacing = 15
      return UICollectionViewCompositionalLayout(section:section)
  }


} //class CompactViewController
extension CompactViewController: UICollectionViewDataSource{
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? CollectionViewCell{
    
    cell.configure(with:pokemons[indexPath.row])
      print("dequed \(cell.pokemonLabel.text)")
      return cell
    }
    return  CollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemons.count
  }
  
 
}
  
extension CompactViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print("you tapped me")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension CompactViewController: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width:120, height:120)
  }
}
