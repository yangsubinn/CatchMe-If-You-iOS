## 🌈 Naming
### 변수
- lowerCamelCase 사용<br/>
  
  ```swift
    var numberOfLines = 20
  ```
### 상수
- lowerCamelCase 사용<br/>

  ```swift
    let developers: [String] = ["윤아", "루희", "수빈"]
  ```
### 함수
- lowerCamelCase 사용
- 함수명은 꼭 동사로 시작합니다.
- 같은 의미를 공유하는 함수에 대해 동일한 기본 이름을 줍니다.
- 함수명은 기능에 기반한 이름으로 짓습니다. <br/>
 
  - 팩토리 메서드는 `make`라는 이름으로 시작
  - 설정 메서드는 `set`으로 시작
  - 네트워크 통신은 `request`로 시작
  - 어떤 설정에 대한 구성은 `config(configure)`로 시작
  
  ```swift
      func configUI() {
         // configure code
      } 
  ```

### 클래스
- UpperCamelCase 사용
  ```swift
    class ViewController {
       // code
    }
  ```

### 델리게이트
- 무엇을 해야하는지 설명하는 프로토콜은 명사로 구성합니다.
- 가능성을 설명하는 프로토콜은 `-able`, `-ible`로 끝나야 합니다.
- 델리게이트 메서드를 만들 때 이름이 없는 첫 번째 매개변수는 델리게이트 이름이어야 합니다.
  ```swift
    protocol ImagePickerDelegate: AnyObject {
        func imagePickerClickedToPresent(_ imagePicker: ImagePickerController,
                                   completion: @escaping (([PHAsset]) -> Void))
    }
  ```
### Objects
- Object관련 변수는 자신의 Object를 축약해서 쓰지 않습니다

  **선호하는 예제:**
  
  ```swift
    let backButton = UIButton()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
  ```
  
  **선호하지 않은 예제:**

  ```swift
    let backBtn = UIButton()
    let profileImage = UIImageView()
    let nameText = UILabel()
  ```
<br/>

## 🌈 빈 배열과 빈 딕셔너리
- 빈 배열과 빈 딕셔너리의 경우 Type Annotation을 사용한다.

**선호하는 예제:**

```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

**선호하지 않은 예제:**

```swift
var names = [String]()
var lookup = [String: Int]()

if {

} else if {

} else {

}
```

<br/>
  
## 🌈 Code Organization
- Extension을 사용하여 코드를 논리적 기능 블록으로 구성합니다.
- `//MARK: -` 를 표현해주는 것이 좋다

  **선호하는 예제:**

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

  **선호하지 않은 예제:**

  ```swift
  classMyViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    // all methods
  }
  ```
  
### Minimal Imports
- 불필요한 Import는 하지 않습니다.
- UIKit을 임포트 했으면 Foundation을 임포트 하지 않아도 됩니다.

### Self 사용 피하기
- 간결함을 위해, Swift는 객체의 프로퍼티에 접근하거나 메서드 호출할 필요가 없는 경우에 **self** 사용을 피한다.
- **컴파일러에 의해 요구될 때에만 self를 사용**한다(@escaping 클로저나 초기화에서 인자가 프로퍼티와 애매모호할 때).
- 다른 말로, self 없이 컴파일하는 경우에 생략한다.

### 들여쓰기, 띄어쓰기
- 들여쓰기는 항상 탭(tab)을 사용합니다.
- 콜론(:)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
  
  ```swift
    class NavigationBar: UIView {
      let names: [String: String]?
      
      // code ...
    }
  ```
- 괄호안은 콤마(,), 콜론(:) 오른쪽에만 공백을 주고 나머지는 붙여 씁니다.
  ```swift
    func configUI(color: UIColor, text: String) { }
  ```
  
