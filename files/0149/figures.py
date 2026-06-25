"""
HIP 149 Decision 1 figures.

Run: uv run --with matplotlib python files/0149/figures.py

Worked-example inputs: carrier pays a fixed ~$9,100/day for ~91,000 GB/day of
offload (a ~$0.10/GB payer rate), Mobile data deployer baseline ~13,870 HNT/day,
alpha ~0.625 (70% data bucket x ~0.89 Mobile share), target = 50% of the payer
rate = $0.05/GB.

Terminology: the "top-up" is the HNT the mechanism adds on top of normal
emissions (HIP 20 schedule + net-emissions re-emit) to reach the floor. New
daily total emissions = normal emissions + top-up; the top-up is the added
amount, never the total. The top-up is bounded by recently burned HNT (the burn
bound), so it never adds to net supply.
"""

import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

CARRIER_USD_DAY = 9_100.0
GB_DAY = 91_000.0
BASELINE_HNT = 13_870.0
ALPHA = 0.625
TARGET_USD_GB = 0.05  # 50% of the $0.10/GB payer rate

BURN = "#f59e0b"     # HNT recently burned (the burn bound)
TOPUP = "#2563eb"    # HNT minted for the top-up (added on top of normal emissions)
TARGET = "#16a34a"   # the target line
INK = "#1f2933"
MUTED = "#6b7280"

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "axes.edgecolor": "#d1d5db",
    "axes.linewidth": 0.8,
    "axes.titlesize": 13,
    "axes.titleweight": "bold",
    "figure.dpi": 150,
})


def burn_bound_for(price):
    return CARRIER_USD_DAY / price


def topup_demand_for(price):
    d_target = 0.5 * CARRIER_USD_DAY / price
    return max(0.0, (d_target - BASELINE_HNT) / ALPHA)


def delivered_usd_gb(price, smoothed):
    top_up = min(smoothed, topup_demand_for(price))
    delivered_hnt = BASELINE_HNT + ALPHA * top_up
    return delivered_hnt * price / GB_DAY


def thousands(x, _pos):
    return f"{x/1000:,.0f}k"


# ---------------------------------------------------------------- Figure 1
def figure_one():
    prices = [0.10, 0.025]
    labels = ["HNT at $0.10", "HNT at $0.025"]
    bounds = [burn_bound_for(p) for p in prices]
    topups = [min(burn_bound_for(p), topup_demand_for(p)) for p in prices]

    fig, ax = plt.subplots(figsize=(8, 4.6))
    x = range(len(prices))
    w = 0.34
    b1 = ax.bar([i - w / 2 for i in x], bounds, w, label="HNT recently burned (the burn bound)", color=BURN)
    b2 = ax.bar([i + w / 2 for i in x], topups, w, label="HNT minted for the top-up", color=TOPUP)

    for bars in (b1, b2):
        for r in bars:
            ax.annotate(f"{r.get_height():,.0f}", (r.get_x() + r.get_width() / 2, r.get_height()),
                        ha="center", va="bottom", fontsize=9, color=INK,
                        xytext=(0, 2), textcoords="offset points")

    for i, c in enumerate(bounds):
        ax.annotate("$0.05/GB delivered", (i, c + max(bounds) * 0.07), ha="center", fontsize=10,
                    color=TARGET, fontweight="bold")

    ax.set_xticks(list(x))
    ax.set_xticklabels(labels, fontsize=11)
    ax.set_ylabel("HNT per day")
    ax.yaxis.set_major_formatter(FuncFormatter(thousands))
    ax.set_ylim(0, max(bounds) * 1.22)
    ax.set_title("Figure 1 — The target is affordable at any HNT price")
    ax.legend(loc="upper left", frameon=False, fontsize=9.5)
    ax.spines[["top", "right"]].set_visible(False)
    fig.text(0.5, -0.10,
             "The top-up (HNT added on top of normal emissions) stays under the HNT burned that day at every "
             "price, so it never\nadds to net supply. When the price falls, only the HNT count scales; the dollar value "
             "delivered is unchanged.\nNormal emissions already cover part of the floor, so the top-up is smaller "
             "than the full target.",
             ha="center", fontsize=8.5, color=MUTED)
    fig.tight_layout()
    fig.savefig("files/0149/decision-1-affordable-at-any-price.png", bbox_inches="tight")
    plt.close(fig)


# ---------------------------------------------------------------- Figure 2
def figure_two():
    epochs = list(range(0, 22))
    crash = 6
    ramp_end = 20

    def price(e):
        return 0.10 if e < crash else 0.025

    def smoothed(e):
        if e < crash:
            return burn_bound_for(0.10)          # 91,000
        if e >= ramp_end:
            return burn_bound_for(0.025)         # 364,000
        frac = (e - crash) / (ramp_end - crash)
        return burn_bound_for(0.10) + frac * (burn_bound_for(0.025) - burn_bound_for(0.10))

    delivered = [delivered_usd_gb(price(e), smoothed(e)) for e in epochs]
    target = [TARGET_USD_GB] * len(epochs)
    burn = [smoothed(e) for e in epochs]

    fig, ax = plt.subplots(figsize=(8.4, 4.6))
    ax.plot(epochs, delivered, color=TOPUP, lw=2.4, marker="o", ms=3.5,
            label="$/GB delivered to deployers", zorder=3)
    # Target drawn on top so it stays visible even where delivery sits on it.
    ax.plot(epochs, target, color=TARGET, lw=2.0, ls="--", label="target: $0.05/GB", zorder=5)
    ax.fill_between(epochs, delivered, target, where=[d < t for d, t in zip(delivered, target)],
                    color=TOPUP, alpha=0.10, zorder=1)

    ax.axvline(crash, color="#dc2626", lw=1, ls=":", zorder=1)
    ax.annotate("HNT price drop", (crash + 0.25, 0.058), color="#dc2626", fontsize=9, ha="left")
    ax.annotate("shortfall", ((crash + 12) / 2 + 1, 0.034), color=MUTED, fontsize=9, ha="center")

    ax.set_xlabel("epochs (≈ days) →")
    ax.set_ylabel("$/GB delivered to deployers")
    ax.set_ylim(0, 0.062)
    ax.set_xticks([])
    ax.yaxis.set_major_formatter(FuncFormatter(lambda v, p: f"${v:.2f}"))
    ax.set_title("Figure 2 — After an HNT price drop, delivery dips below target, then recovers")
    ax.spines[["top"]].set_visible(False)

    ax2 = ax.twinx()
    ax2.plot(epochs, burn, color=BURN, lw=1.6, ls="-", alpha=0.8,
             label="HNT recently burned (the burn bound)")
    ax2.set_ylabel("HNT recently burned (the burn bound)", color=BURN)
    ax2.tick_params(axis="y", colors=BURN)
    ax2.yaxis.set_major_formatter(FuncFormatter(thousands))
    ax2.set_ylim(0, burn_bound_for(0.025) * 1.1)
    ax2.spines[["top"]].set_visible(False)

    lines1, lab1 = ax.get_legend_handles_labels()
    lines2, lab2 = ax2.get_legend_handles_labels()
    ax.legend(lines1 + lines2, lab1 + lab2, loc="lower right", frameon=False, fontsize=9)

    fig.text(0.5, -0.02,
             "The top-up is bounded by HNT recently burned. When the price drops, that average lags for 1–2 weeks, "
             "so delivery\nfalls short of the target; as the burn average catches up, the bound stops binding and delivery "
             "returns to the full target.",
             ha="center", fontsize=8.5, color=MUTED)
    fig.tight_layout()
    fig.savefig("files/0149/decision-1-shortfall-and-recovery.png", bbox_inches="tight")
    plt.close(fig)


if __name__ == "__main__":
    figure_one()
    figure_two()
    print("wrote files/0149/decision-1-affordable-at-any-price.png")
    print("wrote files/0149/decision-1-shortfall-and-recovery.png")
