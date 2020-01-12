From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 12 Jan 2020 16:11:35 +0000
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-Id: <19f684bb-42ad-6c79-f6b8-102f6e036570@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
 <20200112.000504.1994757840298424991.davem@davemloft.net>
In-Reply-To: <20200112.000504.1994757840298424991.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org, keescook@chromium.org, lkp@intel.com

On 1/12/20 12:05 AM, David Miller wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> Date: Mon, 30 Sep 2019 19:15:12 -0700
> 
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
> I'll add an .exit.data to arch/sparc/kernel/vmlinux.lds.S to fix this.
> 

Thanks.

-- 
~Randy
