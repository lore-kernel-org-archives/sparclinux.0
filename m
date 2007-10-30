From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 02:43:32 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47269A54.2040704@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Tue, 30 Oct 2007 01:50:30 +0100
> 
>> What we're missing here is a probably important piece:
>>
>> If dpkg-query is running during a build, it is running in a fakeroot
>> environment. I've straced that, see the attachment.
>>
>> What I find in the strace are at least several clones, which is the
>> point where aptitude -u crashed according to the straces in
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bugC3187#102
> 
> Thanks for the fakeroot trace.
> 
> I am pretty sure the clone()'s we see here are just normal
> fork()'s, in both the fakeroot's dpkg-query and the aptitude
> case.

I just grepped trough the source of aptitude, there's only one fork, but
that one should not be executed if aptitude has been started as root.
If it is of any use for you I can figure out which piece of code
resulted in the call to clone, or figure out which piece of code results
 results in the use of futexes there.

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
