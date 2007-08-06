From: David Miller <davem@davemloft.net>
Date: Mon, 06 Aug 2007 23:25:31 +0000
Subject: Re: SIGSEGV information on SPARC64
Message-Id: <20070806.162531.39159216.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708061541r2b6f2dcxa1a2f143db3a026b@mail.gmail.com>
In-Reply-To: <a8e8903d0708061541r2b6f2dcxa1a2f143db3a026b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Tue, 7 Aug 2007 10:41:18 +1200

> While I could find the faultive address in siginfo_t, it seems there
> is no way to find the access type(read or write) in it.

Disassemble the instruction and see if it is a load or a store.

Even if the information is added to siginfo_t, you'll need to make
your code work on 10+ years of existing kernels.
