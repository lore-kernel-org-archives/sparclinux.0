From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 12 Jun 2017 20:58:07 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <CAMo8BfK46utS6hTjT2gVUtwQJg2ho77NOHoYPO0rDSVe4a3NJw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201706102219.7auwXKYx%fengguang.wu@intel.com> <002f7627-1ce5-eabb-967d-fe93a3660f03@oracle.com>
 <CAK8P3a24DZ26uQDMJMd-e7WKuM66rPnidaqQHQ4sEhPfQz2xJw@mail.gmail.com>
In-Reply-To: <CAK8P3a24DZ26uQDMJMd-e7WKuM66rPnidaqQHQ4sEhPfQz2xJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Babu Moger <babu.moger@oracle.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, David Miller <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org

On Mon, Jun 12, 2017 at 1:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> That way, we don't have to guess what the toolchain does, but rather
> tell it to do whatever is configured, like we do for most other architectures.
>
> Unfortunately we can't do the same thing on xtensa, as that no longer
> supports the -mbig-endian/-mbig-endian flags in any recent gcc version
> (a long time ago it had them, but they were removed along with many other
> options).

For xtensa we probably need to generate Kconfig fragment that would go
in with the variant subdirectory. That will solve this, and clean up other
options that we currently have for manual selection for xtensa, but there's
actually no choice, i.e. the option has to be selected correctly, there's only
one correct choice and otherwise the kernel either won't build or won't work.
I'll look into it.

-- 
Thanks.
-- Max
