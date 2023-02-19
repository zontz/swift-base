
import UIKit

final class HistoryPercentView: UIView {

    // MARK: - UI

    private lazy var percentLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.black
        layer.cornerRadius = 20
    }

    // MARK: - Public Methods

    /// Update historyPercentView with new percent and color
    func update(with percent: Float) {
        percentLabel.text = "\(String(format:"%.1f", percent*100))%"
        backgroundColor = percent >= 0.5 ? UIColor.systemGreen : UIColor.red.withAlphaComponent(0.5)
    }
}

// MARK: - Layout

extension HistoryPercentView {
    private func setupViews() {
        addSubview(percentLabel)
    }

    private func setupConstraints() {
        percentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
