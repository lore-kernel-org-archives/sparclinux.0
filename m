From: David Miller <davem@davemloft.net>
Date: Wed, 17 May 2017 19:09:04 +0000
Subject: Re: [PATCH sparc] sparc: Fix -Wstringop-overflow warning,[PATCH sparc] sparc: Fix -Wstringop-overflo
Message-Id: <20170517.150904.552599607549781310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <98e7b774-29c5-b669-1bf6-24c1c3f1409e@knights.ucf.edu>
In-Reply-To: <98e7b774-29c5-b669-1bf6-24c1c3f1409e@knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Orlando Arias <oarias@knights.ucf.edu>
Date: Tue, 16 May 2017 15:34:00 -0400

> Greetings,
> 
> GCC 7 introduced the -Wstringop-overflow flag to detect buffer overflows
> in calls to string handling functions [1][2]. Due to the way
> ``empty_zero_page'' is declared in arch/sparc/include/setup.h, this
> causes a warning to trigger at compile time in the function mem_init(),
> which is subsequently converted to an error. The ensuing patch fixes
> this issue and aligns the declaration of empty_zero_page to that of
> other architectures. Thank you.
> 
> Cheers,
> Orlando.
> 
> 
> [1] https://gcc.gnu.org/ml/gcc-patches/2016-10/msg02308.html
> [2] https://gcc.gnu.org/gcc-7/changes.html
> 
> 
> Signed-off-by: Orlando Arias <oarias@knights.ucf.edu>

Applied.
