import numpy as np
import matplotlib.pyplot as plt


def estimate_coef(x, y):
    # number of observations/points
    n = np.size(x)

    # mean of x and y vector
    m_x = np.mean(x)
    m_y = np.mean(y)

    # calculating cross-deviation and deviation about x
    SS_xy = np.sum(y*x) - n*m_y*m_x
    SS_xx = np.sum(x*x) - n*m_x*m_x

    # calculating regression coefficients
    b_1 = SS_xy / SS_xx
    b_0 = m_y - b_1*m_x

    return (b_0, b_1)


def plot_regression_line(x, y, b):
    # plotting the actual points as scatter plot
    plt.scatter(x, y, color="m",
                marker="o", s=30)

    # predicted response vector
    y_pred = b[0] + b[1]*x

    # plotting the regression line
    plt.plot(x, y_pred, color="g")

    # putting labels
    plt.xlabel('N')
    plt.ylabel('log(T)')

    # function to show plot
    plt.savefig('linreg.png')


def find_log_t(b, n):
    # ln(T ) ≥ AN + B
    # print(f'A = {b[1]}')
    # print(f'B = {b[0]}')
    return np.exp(b[1] * n + b[0])


TIME_DURATION_UNITS = (
    ('year', 52*60*60*24*7),
    ('week', 4.34524*60*60*24*7),
    ('week', 60*60*24*7),
    ('day', 60*60*24),
    ('hour', 60*60),
    ('min', 60),
    ('sec', 1)
)


def human_time_duration(seconds):
    if seconds == 0:
        return 'inf'
    parts = []
    for unit, div in TIME_DURATION_UNITS:
        amount, seconds = divmod(int(seconds), div)
        if amount > 0:
            parts.append('{} {}{}'.format(
                amount, unit, "" if amount == 1 else "s"))
    return ', '.join(parts)


def main():
    # observations / data
    x = np.array([7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
                 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39])
    y = np.array(np.log([0.10521099300240166, 0.15021341499959817, 0.2416354289962328, 0.3439694490007241, 0.470406489999732, 0.724029797995172, 0.9506604790003621, 1.1922856739984127, 1.7076673160045175, 1.9136553049975191, 2.5500863709967234, 3.5055022499946062, 5.367009593996045, 6.1344135149993235, 7.464222857997811, 9.121812745994248,
                 10.494020523001382, 12.645645215001423, 15.406358896994789, 20.93883848200494, 23.33166784799687, 27.409279206003703, 33.190984193002805, 39.39581104899844, 49.89208820899512, 58.85613574099989, 58.930240344001504, 71.21800972399797, 74.74693262099754, 91.24242930299806, 117.65081291500246, 122.01986194999336, 129.03711112599558]))

    # estimating coefficients
    b = estimate_coef(x, y)
    # plotting regression line
    plot_regression_line(x, y, b)
    for i in range(400):
        print(i, int(find_log_t(b, i)), human_time_duration(find_log_t(b, i)))


if __name__ == "__main__":
    # https://ntru.org/f/tr/tr012v1.pdf
    main()
