From: David Miller <davem@davemloft.net>
Date: Thu, 02 Apr 2020 13:45:34 +0000
Subject: Re: [sparc64] OOPS after 'serial: core: Allow detach and attach serial device for console'
Message-Id: <20200402.064534.2214710089963468576.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwHdRd=3fzr=-9hdR7_cW2VXXHwoySzbSpWx+aZ1S=ysA@mail.gmail.com>
In-Reply-To: <CADxRZqwHdRd=3fzr=-9hdR7_cW2VXXHwoySzbSpWx+aZ1S=ysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 2 Apr 2020 14:24:59 +0300

>> [    2.505276] f029b788: ttyHV0 at I/O 0x0 (irq = 1, base_baud >> 115200) is a SUN4V HCONS
> 
> Also, this is funny address. Can you elaborate how is this working?

There are no "addresses" for this device as it is implemented via hypervisor
calls.
