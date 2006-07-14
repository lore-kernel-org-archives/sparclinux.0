From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 14 Jul 2006 11:28:45 +0000
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <200607141128.k6EBSjDT014339@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607091040.k69AewNu019891@harpo.it.uu.se>
In-Reply-To: <200607091040.k69AewNu019891@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 13 Jul 2006 16:04:01 -0700 (PDT), David Miller wrote:
>From: Mikael Pettersson <mikpe@it.uu.se>
>Date: Thu, 13 Jul 2006 14:18:33 +0200 (MEST)
>
>> No actual problems, but I noticed some differences in the
>> kernel log:
>
>This should take care of all 4 issues.  The typo in the sunsab
>driver causing the first port to not show up was good for a
>laugh. :)
>
>Let me know if it works for you too.

Works fine. The bug() is gone and I have both ttyS0 and ttyS1
again. Thanks.

(What I wrote previously about my Ultra5 only having one serial
port connector was wrong; I'm so used to DB9 connectors that I
mistook the DB25 connector for something else.)

/Mikael
