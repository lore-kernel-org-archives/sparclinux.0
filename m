From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 18:16:49 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150609.111649.1613386818130198452.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Y Knight <jyknight@google.com>
Date: Tue, 9 Jun 2015 08:07:11 -0400

> Debian glibc has multiarch support disabled (done a couple years ago to try
> to workaround the unreliability, not entirely successfully..), so it's not
> using that routine you mention. It's using
> sysdeps/sparc/sparc32/sparcv9/memcpy.S which points to
> sysdeps/sparc/sparc64/memcpy.S

I bet you stop getting corruptions if you use the appropriate optimized
routine.
