From: David Miller <davem@davemloft.net>
Date: Wed, 14 Dec 2011 17:53:55 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <20111214.125355.2114905092680399303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111211111801.5942ab39@sf.home>
	<4EE80891.70604@landley.net>
	<20111214204225.7c8ec86c@sf.home>
In-Reply-To: <20111214204225.7c8ec86c@sf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: slyich@gmail.com
Cc: rob@landley.net, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

From: Sergei Trofimovich <slyich@gmail.com>
Date: Wed, 14 Dec 2011 20:42:25 +0300

>> ext4_kvmalloc:
> ...
>>         sethi  %hi(___i_page_kernel), %i2      !, tmp112
>>        call    __vmalloc, 0    !
>>         restore %i2, %lo(___i_page_kernel), %o2        ! tmp112,,
> ...
> 
> David: is this code correct? Or it's a compiler bug? I am sparc32 newbie.
> (C source and asm sources of function are in [1])

It is correct, it's a tail call.
