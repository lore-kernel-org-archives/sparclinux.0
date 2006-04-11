From: Jim Gifford <maillist@jg555.com>
Date: Tue, 11 Apr 2006 06:12:07 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <443B48B7.1090809@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> From: Jim Gifford <maillist@jg555.com>
> Date: Mon, 10 Apr 2006 20:24:40 -0700
>
>   
>>     I think the problem may be with the way fdisk is creating the 
>> labels. Here is how they are doing it.
>>     
>
> It's how they are "doing it" eh?
>
> You've shown a data structure, data structures don't "do" anything,
> whereas code executes and "does" things.
>
> What about this data structure layout makes you think fdisk is
> doing something wrong?
>
> Please don't just dump information into the discussion without saying
> what you think it's showing us.  What's wrong with it?
>   
Dave, the reason I say this is parted works. That's what's frustrating, 
because of trying to determine what is actually at fault, is it the 
kernel, or something else.
> People really need to learn how to report bugs properly and help the
> process move forward, instead of backward.  Many people who report
> sparc64 bugs do things which waste time and hinder the debugging
> process.  Cheers to the folks who do not fall into this category, but
> sadly most do and since I'm the only person working on the sparc64
> kernel actively this is incredibly frustrating.
>   
The bottom line somehow the writing of the header is not being done 
correctly. If it's fdisk or something related to the kernel, that's what 
I'm trying to determine.
