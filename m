From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 03 Jan 2011 09:50:13 +0000
Subject: Re: [RFC PATCH] sparc: fake idprom for leon
Message-Id: <20110103095013.GA8408@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110102194024.GA31924@merkur.ravnborg.org>
In-Reply-To: <20110102194024.GA31924@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kristoffer!
On Mon, Jan 03, 2011 at 09:55:05AM +0100, Kristoffer Glembo wrote:
> Hi Sam,
> 
> Thanks for the patch. However we are actually faking the idprom
> in the bootloader instead. So there is an idprom property. 
Much better!

> We have released a new Linux "distribution" for LEON, see this message on the leon_sparc mailing list:
> http://tech.groups.yahoo.com/group/leon_sparc/message/19138
Great stuff. I missed that mail.
I am especially glad to see that you have announced buildroot support :-)
I hope this is the right way to go.
 
> It is a work in progress but it is probably of interest to you.
> It also includes new patches that has not yet been sent to this mailing list but will be soon.
I will take a look at the stuff I know about.

Do you prefer comments cc: to sparclinux or the leon list for the general kernel stuff?
I will not cross-post as the leon list is subscribers only (IIRC).

	Sam
