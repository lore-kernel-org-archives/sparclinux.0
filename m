From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Sun, 02 Dec 2007 15:50:41 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <026701c834fb$17539b50$03c8a8c0@kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Fri, 30 Nov 2007 15:28:55 -0500
>
>> - Smartd seems to make systems using the esp.ko SCSI driver very very
>> unhappy. If your system is esp based, we highly recommend that you
>> disable the smartd service in single-user before fully booting after
>> install.
>
> Didn't we spend half of last year fixing this via my
> completely rewritten new driver? :-)

Agreed. I was one of the testers on this esp/smartd problem, and I can 
confirm that (for me, anyway) it's still fixed.

--Adam

