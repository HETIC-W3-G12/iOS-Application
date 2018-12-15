# EUKO iOS Application

Aplication iOS pour EUKO

## Branches

- master : branche de production
- connexion-inscription : branche de developpement des interfaces de connexion et insciption

## Pré-requis

- Xcode 10.1 minimum
- Swift 4.2

## Conding Style

- Noms de classes et structures en pascal case : `ViewController`
- Noms de variables en camel case : `maVariable` 
- Séparer les partie d'une meme classe dans des extensions précédé d'une `MARK` :
```swift
//MARK: override
extension MyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        // ...        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // ...        
    }
}
``` 
- Utiliser des `TODO` lorsque le code n'est pas encore présent ou qu'une erreure est à gérer.


