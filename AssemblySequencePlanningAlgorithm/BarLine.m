% 数据
Case1=[4.7861 4.098 5.1246 4.4258 0.3422];
Case2=[25.8539 24.9832 33.4218 22.9031 0.9672];
Case3=[137.5182 136.9218 184.183 140.9733 3.1106]
%绘图
x=[1 2 3 4 5];
figure;
box off
yyaxis left
plot(Case3)
ylabel('Computing Time/s')
yyaxis right
plot(Case2)
hold on
plot(Case1)

set(gca,'XTick',[1 2 3 4 5])
xlabel('Algorithms')
ylabel('Computing Time/s')
set(gca,'XTickLabel',{'GA','ACO','GWO','HAWA','ASPM-PG'},'fontsize',12,'FontName','Times New Roman')
set(gca,'YGrid','on')
legend('Train','Vise','Rack');
% 
% h=bar(volume_mean);
% set(h,'BarWidth',1);        % 柱状图的粗细
% set(h,'LineWidth',0.5);
% hold on;
% % set(h(1),'facecolor',[139 35 35]./255) % 第一列数据视图颜色
% % set(h(2),'facecolor','k')        % 第二列数据视图颜色
% ngroups = size(volume_mean,1);
% nbars = size(volume_mean,2);
% groupwidth =min(0.8, nbars/(nbars+1.5));
% % errorbar如果用不同颜色，可以利用colormap的颜色进行循环标记，这个例子没有用到colormap
% %colormap(flipud([0 100/255 0; 220/255 20/255 60/255; 1 215/255 0; 0 0 1]));   % blue / red
% % color=[0 100/255 0; 220/255 20/255 60/255; 1 215/255 0; 0 0 1];
% hold on;
% for i = 1:nbars
% x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
% errorbar(x,volume_mean(:,i),volume_std(:,i),'o','MarkerSize',0.5,'color','k','linewidth',1);
% end
