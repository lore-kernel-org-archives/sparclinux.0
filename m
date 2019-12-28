From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 28 Dec 2019 01:39:14 +0000
Subject: Re: [PATCH v2] y2038: sparc: remove use of struct timex
Message-Id: <CAGRGNgV=vcDTAYpufqk-12pNnJiX79=-aHsMyOBGbXG1YtN=Lw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191216144907.1931511-1-arnd@arndb.de>
In-Reply-To: <20191216144907.1931511-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Deepa Dinamani <deepa.kernel@gmail.com>, sparclinux <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Arnd,

On Tue, Dec 17, 2019 at 1:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct timex' is one of the last users of 'struct timeval' and is
> only referenced in one place in the kernel any more, to convert the
> user space timex into the kernel-internal version on sparc64, with a
> different tv_usec member type.
>
> As a preparation for hiding the time_t definition and everything
> using that in the kernel, change the implementation once more
> to only convert the timeval member, and then enclose the
> struct definition in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FWIW this is:

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
