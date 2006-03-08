From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 00:27:02 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440E24D6.7010901@brokedown.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Alex Deucher wrote:

>Thanks Josh.  What's the limit on ram?  These boxes have 2 GB at the
>moment.  I'm not sure which slots they are in.
>
>Alex
>  
>
Hi Alex,

If you have 2G and you have 1G per cpu bank, you'll see about 1.5 gig. 
If you put 2G in one cpu bank, about 1.8G (by memory).  Mine also used 
to crash when them split, although these days it doesn't do it any more.

Josh

