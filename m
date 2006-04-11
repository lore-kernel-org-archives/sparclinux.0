From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Apr 2006 21:21:51 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <20060411.142151.48160023.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <aragorn@tiscali.nl>
Date: Tue, 11 Apr 2006 20:21:50 +0200

> What are the reasons the code in second/timer.c was changed?
> 
> That the sun4u_notimer support is still needed for a large class of 
> hardware out there has been demonstrated by my tests.

You cannot write to the %tick register on some cpu variants,
it can only be written by the hypervisor.
