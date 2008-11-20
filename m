From: David Miller <davem@davemloft.net>
Date: Thu, 20 Nov 2008 12:29:43 +0000
Subject: Re: Extending Leon-Sparc page table size to 32k
Message-Id: <20081120.042943.158500413.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
In-Reply-To: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "k e" <eiselekd@gmail.com>
Date: Thu, 20 Nov 2008 13:05:54 +0100

> If I use the bit index layout similar to SRMMU's [31-24][23-18][17-12] I
 ...
> - Another possibility is that I modify the index layout to
> [31-28][27-21][20-15].
 ...

You have no choice in these matters, as indexing at each page table
level is determined by hardware.  What does Leon use with 32K pages?

