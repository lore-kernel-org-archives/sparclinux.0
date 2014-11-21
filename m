From: David Miller <davem@davemloft.net>
Date: Fri, 21 Nov 2014 21:11:25 +0000
Subject: Re: [PATCH v2] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <20141121.161125.1089687292230239151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <546FA956.1070005@oracle.com>
In-Reply-To: <546FA956.1070005@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>
Date: Fri, 21 Nov 2014 16:06:30 -0500

> Sorry for the confusion of the prior message. Below was the intended
> commit message.
> 
> -chrish

Please do not subit a new patch in this manner as a reply to a
discussion, you're making it so that I have to edit away all the
unrelated text from your commit message body.

Just make a fresh patch posting to the list.

If you want to add auxiliary information, place it after your commit
message and signoffs, and a line containing just "---" as that tells
the automated tools to not include that and the following text in the
commit message itself.

It's _REALLY_ easy to submit patches properly, by simply mimicking
exactly what other successful patch submitters do.  Any deviation
unless you are experienced is asking for trouble.

Thanks.
