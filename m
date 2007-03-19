From: David Miller <davem@davemloft.net>
Date: Mon, 19 Mar 2007 18:58:19 +0000
Subject: Re: [Systems] Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <20070319.115819.63131235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
In-Reply-To: <1818c1980703052246p5af31178p70296e156b06511a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Mon, 19 Mar 2007 13:40:36 -0300

> Been running some intensive network loads on our T2000 for the last 
> couple of hours and indeed this patch seems to fix it. Previously it 
> would trigger an oops in less than 10 minutes.
> Thanks.

Thanks for testing.
