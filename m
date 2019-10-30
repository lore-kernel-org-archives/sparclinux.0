From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 30 Oct 2019 19:29:40 +0000
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-Id: <9ef8c2a5-8510-c509-4c31-b8684b6e1c67@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
 <201910301131.2739AA83@keescook>
In-Reply-To: <201910301131.2739AA83@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, kbuild test robot <lkp@intel.com>

On 10/30/19 7:34 PM, Kees Cook wrote:
> On Mon, Sep 30, 2019 at 07:15:12PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix tty driver build on SPARC by not using __exitdata.
>> It appears that SPARC does not support section .exit.data.
>>
>> Fixes these build errors:
>>
>> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Fixes: 063246641d4a ("format-security: move static strings to const")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Wow. That commit is from 2.5 years ago. Is the SPARC port still alive?
Yes, it is. No idea why we didn't run into this. I assume it affects certain
configurations only. On Debian, we are always compiling and running the
latest kernel versions on sparc64.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
