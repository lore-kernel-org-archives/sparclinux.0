From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:09:24 +0000
Subject: Re: [PATCH 0/3] tsb expansion for sun4v
Message-Id: <20170223.110924.188571122665796616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170201123823.6273-1-bob.picco@oracle.com>
In-Reply-To: <20170201123823.6273-1-bob.picco@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bob.picco@oracle.com>
Date: Wed,  1 Feb 2017 07:38:20 -0500

> The program was built as:
> 
> gcc -Wall -m64 -o test_with_mmap test_with_mmap.c -lrt -lm

Anything meauring performance should be built with optimizations
enabled, at least -O2.

Also, this test program, if you're giving so much detailed information
on how to use it and run it and what it's results mean, absolutely must
be included in this series somehow.

We have a testing subdirectory, place it there and add it to the test
build Makefile rules.  tools/testing/selftests/  You can create a
sparc subdirectory there.
