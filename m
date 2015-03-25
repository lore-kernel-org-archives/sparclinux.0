From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 25 Mar 2015 22:53:28 +0000
Subject: Re: [PATCH] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <55133C68.4040905@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795630-135778-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795630-135778-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Yes. Sorry. You pointed out many of these formatting issues to me in a prior sunvdc patch that I still need to resubmit. 
David took this and added to it not realizing these issues were there. I will work with David on a resubmission.

So other than that, are you happy with the approach?

-chrish

On 3/25/2015 12:44 AM, David Miller wrote:
> From: David Ahern <david.ahern@oracle.com>
> Date: Thu, 19 Mar 2015 16:07:10 -0400
>
>> -static void mark_core_ids(struct mdesc_handle *hp, u64 mp, int core_id)
>> +static void __cpuinit find_back_node_value(struct mdesc_handle *hp, u64 node,
>> +	       char *srch_val, void(*func)(struct mdesc_handle *, u64, int),
>> +	       u64 val, int depth)
>>   {
>
> Function arguments on the second and subsequent line shall start
> exactly at the first column after the openning parenthesis of
> the function definition/declaration.  You should use the appropriate
> number of TAB then SPACE characters necessary to do so.
>
> If you are only using TAB characters to indent this kind of thing,
> it's probably not right.
>
>> +	/*since we have estimate of how deep, do recursion sanity check */
>> +	if (depth = 0)
>> +		return;
>
> Please capitalize and properly punctuate this.  Also put
> a space after "/*".
>
>> +	mdesc_for_each_arc(arc, hp, node, MDESC_ARC_TYPE_BACK) {
>> +		u64 n = mdesc_arc_target(hp, arc);
>> +		const char *name = mdesc_node_name(hp, n);
>>
>> -				n_name = mdesc_node_name(hp, n);
>> -				if (strcmp(n_name, "cpu"))
>> -					continue;
>> +	if (!strcmp(srch_val, name))
>> +		(*func)(hp, n, val);
>
> This needs one more TAB of indentation.
>
>> +	find_back_node_value(hp, n, srch_val, func, val, depth-1);
>
> This as well.  This doesn't look strange in your editor?
>
>> +static void __cpuinit __mark_core_id(struct mdesc_handle *hp, u64 node,
>> +		int core_id)
>
> Please fix argument indentation.
>
>> +static void __cpuinit __mark_sock_id(struct mdesc_handle *hp, u64 node,
>> +		int sock_id)
>
> Likewise.
>
>> +static void __cpuinit mark_core_ids(struct mdesc_handle *hp, u64 mp,
>> +		int core_id)
>
> Likewise.
>
>> +static void __cpuinit mark_sock_ids(struct mdesc_handle *hp, u64 mp,
>> +		int sock_id)
>
> Likewise.
>
>> +	/*
>> +	 * identify unique cores by looking for cpus backpointed to by
>> +	 * level 1 instruction caches
>> +	 */
>> +
>
> Please capitalize this sentence and format the comment:
>
> 	/* Like
> 	 * this.
> 	 */
>
>> +	/*
>> +	 * identify unique sockets by looking for cpus backpointed to by
>> +	 * level 3 caches
>> +	 */
>
> Likewise.
>
>> +	/* if machine description exposes sockets data use it.
>> +	 * otherwise fallback to use L3 cache
>> +	 */
>
> Capitalize and properly punctuate.
>
>> +		if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7) {
>> +			pr_warn("Machine description does not contain sockets node. Falling back\n");
>> +			pr_warn("to identifying CPUs to sockets using L3 cache which is known to\n");
>> +			pr_warn("be wrong for M7 processors (e.g, lscpu shows wrong number of sockets).\n");
>> +			pr_warn("Please update the firmware.\n");
>> +		}
>
> If this isn't going to happen on FCS hardware, I wouldn't even bother
> with this warning.
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
