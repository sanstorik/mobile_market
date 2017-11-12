import UIKit

class MobileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "mobile"
    private lazy var _presenter = MobileCollectionPresenter(collection: self)
    private var _refresh: UIRefreshControl!
    
    private var _currentPage = 1
    private let _mobilesPerPage = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(red: 239, green: 239, blue: 243)
        collectionView?.register(MobileCell.self, forCellWithReuseIdentifier: cellId)
        
        _presenter.loadMobiles(atPage: _currentPage, perPage: _mobilesPerPage, completeHandler: {
            [unowned self] () -> Void in
            self.collectionView?.reloadData()
        })
        
        setupNavigationBar()
        setupPullToRefresh()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
                    as! MobileCell
        
        if (_presenter.mobilesCount > indexPath.row) {
            cell.mobile = _presenter.mobile(at: indexPath.row)
            
            cell.eventHolder = { (mobile) -> Void in
                print(mobile?.id ?? "no mobile")
            }
        }
        
        let mobilesCount = _mobilesPerPage * _currentPage
        
        if indexPath.row > mobilesCount - _mobilesPerPage / 2 {
            let cachedPage = _currentPage
            
            _currentPage += 1
            _presenter.loadMobiles(atPage: _currentPage, perPage: _mobilesPerPage,
                                   completeHandler: {
                                    [unowned self] () -> Void in
                                    self.collectionView?.insertItems(at:
                                        self.createIndexPathesForNewMobiles(cachedPage))
            })
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _presenter.mobilesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 32) / 2, height: 350)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Смартфоны"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 231, green: 125, blue: 62)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setupPullToRefresh() {
        _refresh = UIRefreshControl()
        _refresh.tintColor = UIColor.red
        _refresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.addSubview(_refresh)
    }
    
    private func createIndexPathesForNewMobiles(_ page: Int) -> [IndexPath] {
        let mobiles = _mobilesPerPage * page
        var pathes = [IndexPath]()
        
        for row in mobiles..<mobiles + _mobilesPerPage {
            pathes.append(IndexPath(row: row, section: 0))
        }
        
        return pathes
    }
    
    @objc private func refresh() {
        _currentPage = 0
        _presenter.clearAndLoadMobiles(atPage: 0, perPage: _mobilesPerPage, completeHandler: {
            [unowned self] () -> Void in
            self.collectionView?.reloadData()
        })
        
        _refresh.endRefreshing()
    }
}
