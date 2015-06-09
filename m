From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 20:45:37 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150609.134537.10408041080684182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Just FYI, I commented out the usleep() in your test program and have
been running your:

seq 64 | xargs -n1 -P64 /bin/sh -c 'while ./a.out; do : ; done'

test, and it's been running flawlessly for 2 hours on my T4.

This is with Linus's current tree.

I'll fire up my T3 later and try to reproduce it there.
