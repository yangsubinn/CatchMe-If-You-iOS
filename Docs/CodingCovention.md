## π Naming
### λ³μ
- lowerCamelCase μ¬μ©<br/>
  
  ```swift
    var numberOfLines = 20
  ```
### μμ
- lowerCamelCase μ¬μ©<br/>

  ```swift
    let developers: [String] = ["μ€μ", "λ£¨ν¬", "μλΉ"]
  ```
### ν¨μ
- lowerCamelCase μ¬μ©
- ν¨μλͺμ κΌ­ λμ¬λ‘ μμν©λλ€.
- κ°μ μλ―Έλ₯Ό κ³΅μ νλ ν¨μμ λν΄ λμΌν κΈ°λ³Έ μ΄λ¦μ μ€λλ€.
- ν¨μλͺμ κΈ°λ₯μ κΈ°λ°ν μ΄λ¦μΌλ‘ μ§μ΅λλ€. <br/>
 
  - ν©ν λ¦¬ λ©μλλ `make`λΌλ μ΄λ¦μΌλ‘ μμ
  - μ€μ  λ©μλλ `set`μΌλ‘ μμ
  - λ€νΈμν¬ ν΅μ μ `request`λ‘ μμ
  - μ΄λ€ μ€μ μ λν κ΅¬μ±μ `config(configure)`λ‘ μμ
  
  ```swift
      func configUI() {
         // configure code
      } 
  ```

### ν΄λμ€
- UpperCamelCase μ¬μ©
  ```swift
    class ViewController {
       // code
    }
  ```

### λΈλ¦¬κ²μ΄νΈ
- λ¬΄μμ ν΄μΌνλμ§ μ€λͺνλ νλ‘ν μ½μ λͺμ¬λ‘ κ΅¬μ±ν©λλ€.
- κ°λ₯μ±μ μ€λͺνλ νλ‘ν μ½μ `-able`, `-ible`λ‘ λλμΌ ν©λλ€.
- λΈλ¦¬κ²μ΄νΈ λ©μλλ₯Ό λ§λ€ λ μ΄λ¦μ΄ μλ μ²« λ²μ§Έ λ§€κ°λ³μλ λΈλ¦¬κ²μ΄νΈ μ΄λ¦μ΄μ΄μΌ ν©λλ€.
  ```swift
    protocol ImagePickerDelegate: AnyObject {
        func imagePickerClickedToPresent(_ imagePicker: ImagePickerController,
                                   completion: @escaping (([PHAsset]) -> Void))
    }
  ```
### Objects
- Objectκ΄λ ¨ λ³μλ μμ μ Objectλ₯Ό μΆμ½ν΄μ μ°μ§ μμ΅λλ€

  **μ νΈνλ μμ :**
  
  ```swift
    let backButton = UIButton()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
  ```
  
  **μ νΈνμ§ μμ μμ :**

  ```swift
    let backBtn = UIButton()
    let profileImage = UIImageView()
    let nameText = UILabel()
  ```
<br/>

## π λΉ λ°°μ΄κ³Ό λΉ λμλλ¦¬
- λΉ λ°°μ΄κ³Ό λΉ λμλλ¦¬μ κ²½μ° Type Annotationμ μ¬μ©νλ€.

**μ νΈνλ μμ :**

```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

**μ νΈνμ§ μμ μμ :**

```swift
var names = [String]()
var lookup = [String: Int]()
```

<br/>
  
## π Code Organization
- Extensionμ μ¬μ©νμ¬ μ½λλ₯Ό λΌλ¦¬μ  κΈ°λ₯ λΈλ‘μΌλ‘ κ΅¬μ±ν©λλ€.
- `//MARK: -` λ₯Ό ννν΄μ£Όλ κ²μ΄ μ’λ€

  **μ νΈνλ μμ :**

  ```swift
  class MyViewController:UIViewController {
    // class stuff here
  }

  // MARK: - UITableViewDataSource
  extension MyViewController:UITableViewDataSource {
    // table view data source methods
  }

  // MARK: - UIScrollViewDelegate
  extension MyViewController:UIScrollViewDelegate {
    // scroll view delegate methods
  }

  ```

  **μ νΈνμ§ μμ μμ :**

  ```swift
  classMyViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    // all methods
  }
  ```
  
### Minimal Imports
- λΆνμν Importλ νμ§ μμ΅λλ€.
- UIKitμ μν¬νΈ νμΌλ©΄ Foundationμ μν¬νΈ νμ§ μμλ λ©λλ€.

### Self μ¬μ© νΌνκΈ°
- κ°κ²°ν¨μ μν΄, Swiftλ κ°μ²΄μ νλ‘νΌν°μ μ κ·Όνκ±°λ λ©μλ νΈμΆν  νμκ° μλ κ²½μ°μΒ **self**Β μ¬μ©μ νΌνλ€.
- **μ»΄νμΌλ¬μ μν΄ μκ΅¬λ  λμλ§ selfλ₯Ό μ¬μ©**νλ€(@escaping ν΄λ‘μ λ μ΄κΈ°νμμ μΈμκ° νλ‘νΌν°μ μ λ§€λͺ¨νΈν  λ).
- λ€λ₯Έ λ§λ‘, self μμ΄ μ»΄νμΌνλ κ²½μ°μ μλ΅νλ€.

### λ€μ¬μ°κΈ°, λμ΄μ°κΈ°
- λ€μ¬μ°κΈ°λ ν­μ ν­(tab)μ μ¬μ©ν©λλ€.
- μ½λ‘ (:)μ μΈ λμλ μ½λ‘ μ μ€λ₯Έμͺ½μλ§ κ³΅λ°±μ λ‘λλ€.
  
  ```swift
    class NavigationBar: UIView {
      let names: [String: String]?
      
      // code ...
    }
  ```
- κ΄νΈμμ μ½€λ§(,), μ½λ‘ (:) μ€λ₯Έμͺ½μλ§ κ³΅λ°±μ μ£Όκ³  λλ¨Έμ§λ λΆμ¬ μλλ€.
  ```swift
    func configUI(color: UIColor, text: String) { }
  ```
  
