From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 00:51:49 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47268025.3010005@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bernd Zeimetz wrote:
>> Here you go.
>>
>> (Mind, this is capturing the current status of the chroot, which is fairly
>> unclean, because right now it happens to be building python-qt4-4.3.1.)
> 
> What we're missing here is a probably important piece:
> 
> If dpkg-query is running during a build, it is running in a fakeroot
> environment. I've straced that, see the attachment.

what I forgot to mention - this strace was taken as non-root user of
course, not sure what fakeroot does if it's called as root.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
