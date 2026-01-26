Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE626CE2C;
	Mon, 26 Jan 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454577; cv=none; b=nOmp/yrTj8Wm6N/nSjE17CUMWntqlk4JaJ+o0TTPdvGQNkdKjSy8g+tD8bbifnacuWKI9b5MF+31jpnX1s5FEwn2Hn0VDoiRvbytFwZymn3Cwvy099yr4G21iFsWzcCqgBUyMp5MiQr921kkfVfXDuZ7JdShVxptEtty3kAAozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454577; c=relaxed/simple;
	bh=cLFcy6Z9Pdtecg2U9FAo2ddua3xRPw/vDkzI2/8JyD8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gfzaWhqsg5SLp2eahl3DUwpU9xyA5r9auhtBsXJxwDwfjaKl3FcTyoUsBxNRUsMlMaK59TE+yrFgKW2tXrzvaYE5sNy4Wdjj8Q0csN04MAMGg1mIMThuK5XEwlNi8BJbREmOoZq+EwFE2IW2pXtTxeAOzpyABRbgU7h54Q6GPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vlvTX/uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vlvTX/uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC125C116C6;
	Mon, 26 Jan 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769454577;
	bh=cLFcy6Z9Pdtecg2U9FAo2ddua3xRPw/vDkzI2/8JyD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vlvTX/uunId+50ZKm4OCK+Dh/JaILoGTR/N8IWJY+mw+dQCFvc9MxpH2VBs635lbi
	 bWhlQ2uouXYSN4xshSrHocqOt6eRIr3E8Ijqq0P+gO8YP6Ezb0xUcqVjsyOzGJmll0
	 RndRO61fpRG1JTW2KfQfYCFKrFktfXO+lJGklub8=
Date: Mon, 26 Jan 2026 11:09:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: chengkaitao <pilgrimtao@gmail.com>, davem@davemloft.net,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 kevin.brodsky@arm.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
 chengkaitao@kylinos.cn, willy@infradead.org, zhengqi.arch@bytedance.com,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v5 1/2] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
Message-Id: <20260126110936.4e47e1b0820198e342339038@linux-foundation.org>
In-Reply-To: <aaf30e1e-be55-4212-b096-69f71bafd406@gaisler.com>
References: <20260111074453.66728-1-pilgrimtao@gmail.com>
	<20260111074453.66728-2-pilgrimtao@gmail.com>
	<aaf30e1e-be55-4212-b096-69f71bafd406@gaisler.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 15:50:34 +0100 Andreas Larsson <andreas@gaisler.com> wrote:

> On 2026-01-11 08:44, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> > 
> > 1. In the SPARC architecture, reimplemented vmemmap_populate using
> > vmemmap_populate_hugepages.
> > 2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
> > when vmemmap_alloc_block returns NULL.
> 
> This patch seems to potentially make more functional changes than what
> the descriptions gives impression of.
> 
> Given the amount of changes this seems to introduce, more on that below,
> I'd like to see more description on the changes and why they can be done
> than this.
> 
> Nit: use active language, "reimplement", not "reimplemented".

Thanks, I'll drop the v5 version of this patchset.
