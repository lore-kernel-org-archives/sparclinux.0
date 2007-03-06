From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 06 Mar 2007 13:43:41 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <200703060743.41795.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
In-Reply-To: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Once upon a time Tuesday 06 March 2007, David Miller wrote:

> I'm very suspicious of this bug because there are no reports of it
> on Debian or Ubuntu systems, and that's also the environment
> under which I've been beating the crap out of Niagara with 2.6.x
> kernels.

since i reported the problem previously. the patch provided fixed the issue 
completely.  I'm running the corona Tree of aurora which has gcc 4.1.1 my 
T1000 is used as a build box for aurora extras.  It regularly sees high 
loads.

Dennis
