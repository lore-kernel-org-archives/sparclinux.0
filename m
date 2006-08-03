From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 03 Aug 2006 15:49:01 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <44D21AED.7080807@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Smolik napsal(a):
> Marc Zyngier napsal(a):
> 
>>>>>>> "Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:
>>
>>
>>
>> Daniel> I test 2.6.18-rc2 over rsc console and I see nothing after
>> Daniel> Uncompresing Linux.... With 2.6.17.2 work well. E250 Debian Sid.
>> Daniel> I will test 18rc-3 and see.
>>
>> As David wrote, there was some fixes to E250 serial console introduced
>> between rc2 and rc3.
>>
>> Please note that I didn't test RSC console though (I don't trust RSC
>> enough to let it handle my console directly, and I only use it to
>> power-on/reset the machine remotely).
>>
>>     M.
> 
> 
> Yes I understatd. I compile 2.6.18-rc2 and PROM console via rsc didn't 
Sorry 2.6.18-rc3 of course   ^^^^^^^^^^^

			Dan



> work :-( and my E250 with the same config as 2.6.17.2 didn't boot but I 
> don't know why because I haven't console :-).
> 
> 
>             Dan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

