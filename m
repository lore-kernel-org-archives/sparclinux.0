From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 14 Dec 2019 14:44:22 +0000
Subject: Re: [Y2038] [PATCH v2 24/24] y2038: sparc: remove use of struct timex
Message-Id: <CAK8P3a1Tuv766qK0RX+ZkNiqDqiOOHPeawFXT0V-Zsj5ZKAAQg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-15-arnd@arndb.de>
 <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
In-Reply-To: <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>

On Sat, Dec 14, 2019 at 2:38 AM Julian Calaby <julian.calaby@gmail.com> wrote:
> On Sat, Dec 14, 2019 at 7:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Am I mis-reading the patch, or is "kt" not defined?

You are right, and there are other problems in this patch that I should have
found in a trivial compile-test. Please disregard this patch, it should not have
been part of this set before I had gotten around to at least some testing.

When I collected stuff from my backlog, I only made sure that this one had
no dependencies on other work, but failed to realize that sparc64 was not
part of my build test matrix and that the 0day bot had not seen it either.

       Arnd
