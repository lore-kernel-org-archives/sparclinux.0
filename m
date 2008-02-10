From: Robert Reif <reif@earthlink.net>
Date: Sun, 10 Feb 2008 21:44:40 +0000
Subject: Re: sparc compile error
Message-Id: <47AF7048.3060200@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi> <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com> <20080210153355.GA6737@palantir8> <alpine.DEB.1.00.0802101117510.5043@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.1.00.0802101117510.5043@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Rientjes <rientjes@google.com>
Cc: Martin Habets <errandir_news@mph.eclipse.co.uk>, Adrian Bunk <bunk@kernel.org>, wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

David Rientjes wrote:

>Please try Linus' latest git that includes 60c12b12 (from yesterday) that 
>fixes this issue.
>
>  
>
I get this with latest git:

  CC      init/do_mounts.o
In file included from include/linux/mm.h:39,
                 from include/linux/memcontrol.h:24,
                 from include/linux/swap.h:8,
                 from include/linux/suspend.h:7,
                 from init/do_mounts.c:6:
include/asm/pgtable.h:344: warning: parameter names (without types) in 
function declaration
include/asm/pgtable.h:345: warning: parameter names (without types) in 
function declaration
include/asm/pgtable.h:346: error: expected '=', ',', ';', 'asm' or 
'__attribute__' before '___f___swp_entry'
make[1]: *** [init/do_mounts.o] Error 1


