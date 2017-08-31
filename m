From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Thu, 31 Aug 2017 09:04:20 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <4d58d653-5e9e-3f29-7dfc-e60e7e7d8cfa@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 08/31/2017 05:50 AM, Rob Gardner wrote:
> On 08/30/2017 01:22 AM, John Paul Adrian Glaubitz wrote:
>> Hi Rob!
>>
>> On 08/30/2017 01:36 AM, Rob Gardner wrote:
>>> To answer the most obvious question "who will use this?", there is a
>>> companion userspace library which will be published under UPL
>>> shortly. This is a comprehensive collection of higher level functions
>>> along with tests and documentation. We'll include a link to this before
>>> the code is submitted as a patch.
>>
>> Out of curiosity. Do you know what the current progress with the publication
>> of the patches for LDOM control support on Linux are? I have seen that Oracle
>> Linux now ships the LDOM utilities, so I assume that it is possible to run
>> Oracle Linux in the control domain. But since the sources are missing for
>> the LDOM packages in OL, it's not yet possible to package it for Debian.
>>
>> It would be really nice to have Debian running in the control domain,
>> currently we're still running Solaris there on the SPARC T5 we have.
>>
>> Adrian
>>
>
> I do not know offhand the state of any ldom control support patches.
> It is definitely possible to run linux in the control domain, I've
> seen it being done. I hope they plan on sharing the sources for
> that.
>

It's possible to run Linux as a LDoms control domain with the Oracle SPARC UEK kernel.

See here: https://docs.oracle.com/cd/E37670_01/E86243/html/InstallControlDomTask.html

However, all required drivers are not upstream yet. In particular, we have
changes to the ds driver, and new vldc and vlds driver. We are working on
upstreaming those drivers which are required to run the LDoms Manager.

In addition, you need the ldoms and the ldomsmanager packages which are available here:

Binary: http://yum.oracle.com/repo/OracleLinux/OL6/latest/sparc64/index.html
Source: http://yum.oracle.com/repo/OracleLinux/OL6/latest/source/index_src.html

alex.
