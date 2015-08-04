From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 04 Aug 2015 13:58:24 +0000
Subject: Re: Build failure (sparc32:allmodconfig) in -next due to 'memcg: export struct mem_cgroup'
Message-Id: <20150804135823.GH28571@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20150802030220.GA25165@roeck-us.net>
 <20150804121801.GA28571@dhcp22.suse.cz>
 <CAGRGNgX4Y2P+Vo-DnHoudaP4Z7bNxamVepmUM+s6pwgWAN4kVw@mail.gmail.com>
In-Reply-To: <CAGRGNgX4Y2P+Vo-DnHoudaP4Z7bNxamVepmUM+s6pwgWAN4kVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Vladimir Davydov <vdavydov@parallels.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

On Tue 04-08-15 23:42:09, Julian Calaby wrote:
> It's failing because you're trying to compile sparc32 code with an
> x86_64 compiler.
> 
> Try something like:
> PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH
> CROSS_COMPILE=sparc-linux- ARCH=sparc32 make

Ohh, right you are. I misunderstood and thought this was a x86 build of
the compiler for sparc. This has worked out. It works now. Thanks a lot!
-- 
Michal Hocko
SUSE Labs
